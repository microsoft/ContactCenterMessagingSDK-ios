//
//  ViewController.swift
//  ContactCenterMessagingApp
//
//  Created by Microsoft on 03/06/24.
//  Copyright © 2024 Microsoft. All rights reserved.
//

import UIKit
import Foundation
import ContactCenterMessagingSDK
import ContactCenterMessagingWidget
import Security

class ViewController: UIViewController {
    
    @IBOutlet weak var widgetIdTextField: UITextField!
    @IBOutlet weak var orgUrlTextField: UITextField!
    @IBOutlet weak var orgIdTextField: UITextField!
    @IBOutlet weak var btnStartChat: UIButton!
    @IBOutlet weak var viewAddDetails: UIView!
    @IBOutlet weak var authTokenTextField: UITextField!
    @IBOutlet weak var btnClearChat: UIButton!
    private var workItem : DispatchWorkItem? = nil

    private var credentials = OrgCredentials.placeholder

    weak var liveChatMessagingVC: LiveChatMessagingViewController? // Keeping optional so automatically invalidate instance so next launch creates fresh one
    
    private let blueOCStandardColor = UIColor(red: 47/255.0, green: 90/255.0, blue: 146/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        orgIdTextField.delegate = self
        orgUrlTextField.delegate = self
        widgetIdTextField.delegate = self
        styleAddDetailsView()

        credentials = OrgCredentialsStore.load()
        applyCredentialsToUI()

        setProdAPI()
        btnStartChat.backgroundColor = .lightGray
        btnStartChat.isEnabled = false
        
        LiveChatMessaging.shared.initOmnichannelChatSDK(self) { [self] success, error in
            if success != nil {
                checkChatGoingOn { isChatGoingOn in
                    DispatchQueue.main.async { [self] in
                        btnStartChat.setTitle(isChatGoingOn ? "Restart Chat" : "Start Chat", for: .normal)
                        enableStartChatButton()
                    }
                }
            } else {
                enableStartChatButton()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func actionBtnStartChat(_ sender: Any) {
        let entered = readCredentialsFromUI()
        guard entered.isComplete else {
            showError()
            return
        }

        credentials = entered
        OrgCredentialsStore.save(entered)
        setProdAPI()

        if liveChatMessagingVC == nil {
            liveChatMessagingVC = launchMessagingViewController(delegate: self)
        }
        
        setMessagingViewProperties(vc: liveChatMessagingVC!)

        if let apnsToken = UserDefaults.standard.value(forKey: "APNSToken") as? String {
            LiveChatMessaging.shared.setAPNSToken(tokenData: apnsToken)
            print("APNS Token passed : ",LiveChatMessaging.shared.getAPNSToken() as Any)
        }

        liveChatMessagingVC!.modalPresentationStyle = .fullScreen
        self.present(liveChatMessagingVC!, animated: true, completion: nil)
    }

    @IBAction func actionClearChat(_ sender: Any) {
        LiveChatMessaging.shared.resetAllData()
        credentials = .empty
        applyCredentialsToUI()
        OrgCredentialsStore.clear()
        btnStartChat.setTitle("Start Chat", for: .normal)
    }

    @IBAction func actionAddDefaultCred(_ sender: Any) {
        LiveChatMessaging.shared.resetAllData()
        credentials = .placeholder
        applyCredentialsToUI()
    }

    func setProdAPI() {
        let engage = LCWOmniChannelConfigRequest(orgId: credentials.orgId, orgUrl: credentials.orgUrl, widgetId: credentials.widgetId)
        // ** Nate: Update LCWChatSDKConfigRequest as per your requirement **
        LiveChatMessaging.shared.initialize(omniChannelConfig: engage, chatSDKconfig: LCWChatSDKConfigRequest(), initializeChatConfig: nil, authToken: credentials.authToken, environment: "test")
    }

    func showError() {
        let ac = UIAlertController(title: "Alert!", message: "Please add all details.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in}
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }

    private func applyCredentialsToUI() {
        orgIdTextField.text = credentials.orgId
        orgUrlTextField.text = credentials.orgUrl
        widgetIdTextField.text = credentials.widgetId
        authTokenTextField.text = credentials.authToken
    }

    private func readCredentialsFromUI() -> OrgCredentials {
        OrgCredentials(
            orgId: orgIdTextField.text ?? "",
            orgUrl: orgUrlTextField.text ?? "",
            widgetId: widgetIdTextField.text ?? "",
            authToken: authTokenTextField.text ?? ""
        )
    }

    private func styleAddDetailsView() {
        viewAddDetails.layer.borderColor = blueOCStandardColor.cgColor
        viewAddDetails.layer.borderWidth = 0.5
        viewAddDetails.layer.cornerRadius = 5
        btnStartChat.layer.cornerRadius = 5
        btnStartChat.setTitle("Start Chat", for: .normal)
    }

    private func enableStartChatButton() {
        btnStartChat.isEnabled = true
        btnStartChat.backgroundColor = blueOCStandardColor
    }

    func checkChatGoingOn(completionHandler: @escaping ((_ isChatGoingOn: Bool) -> Void)) {
        if self.isViewLoaded && self.viewIfLoaded?.window != nil {
            if LiveChatMessaging.shared.getChatProgress() {
                LiveChatMessaging.shared.getConversationDetails(LCWLiveChatContextRequest(liveChatContext: LiveChatMessaging.shared.getLiveChatContext())) { success, error in
                    if let responseObj = success?.getResponse() as? [String: Any] {
                        if let state = responseObj["state"] as? String {
                            if state !=  "Closed" || state !=  "WrapUp" {
                                completionHandler(true)
                                return
                            }
                        }
                    }
                    completionHandler(false)
                }
            } else {
                completionHandler(false)
            }
        }
    }
}

extension ViewController: LCWMessagingDelegate {
    
    func onNinaExternalLink(urlLinkMessage: String) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: urlLinkMessage)!, options: [:], completionHandler: { (_) in
            })
        } else {
            UIApplication.shared.openURL(URL(string: urlLinkMessage)!)
        }
    }
    
    func onChatMinimizeButtonClicked() {
        print("*** onChatMinimizeButtonClicked")
        if LiveChatMessaging.shared.getChatProgress() {
            btnStartChat.setTitle("Restart Chat", for: .normal)
        }
    }

   func onChatCloseButtonClicked(){
       print("*** onChatCloseButtonClicked")
   }

   func onViewDisplayed(){
       print("*** onViewDisplayed")
   }

   func onChatInitiated(){
       print("*** onChatInitiated")
   }

   func onCustomerChatEnded(){
       print("*** onCustomerChatEnded")
       btnStartChat.setTitle("Start Chat", for: .normal)
   }

   func onAgentChatEnded(){
       print("*** onAgentChatEnded")
       btnStartChat.setTitle("Start Chat", for: .normal)
   }

   func onTitleOption1Clicked(){
       print("*** onTitleOption1Clicked")
   }

   func onTitleOption2Clicked(){
       print("*** onTitleOption2Clicked")
   }

   func onAgentAssigned(){
       print("*** onAgentAssigned")
   }

   func onLinkClicked(url: String){
       print("*** onLinkClicked")
   }

   func onNewCustomerMessage(message: String?){
       print("*** onNewCustomerMessage")
   }

   func onNewMessageReceived(message: ContactCenterMessagingSDK.LCWGetMessageResponse?){
       print("*** onNewMessageReceived")
   }

   func onError(state: ContactCenterMessagingWidget.MessagingErrorStates, errorMessage: String?){
       print("*** onError")
   }

   func onChatRestored(){
       print("*** onChatRestored")
   }

   func onPreChatSurveyDisplayed(){
       print("*** onPreChatSurveyDisplayed")
   }

}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController {
    func setMessagingViewProperties(vc: LiveChatMessagingViewController) {
        let messagingView = LCWMessagingViewProperties()
        messagingView.isChatFromBottom = true
        
        // FlexUIProperties
        let sa = messagingView.flexUIViewProperties
        sa.useFlexUI = true // imp
        
        sa.backgroundColor = .white
        sa.containerBorderColor = UIColor.darkGray
        sa.containerBorderWidth = 1.5
        sa.containerCornerRadius = 8
        sa.containerSeparatorColor = UIColor.darkGray
        sa.containerSeparatorHeight = 0
        
        sa.buttonTitleColor = UIColor.darkGray
        sa.buttonBorderWidth = 1.5
        sa.buttonBorderColor = UIColor.darkGray
        sa.buttonCorners = [.bottomLeft,.topRight]
        sa.buttonCornerRadius = 12

        sa.buttonHeight = 44
        sa.itemSpacing = 8
        sa.maxHeight = 200
        sa.minButtonWidth = 80

        vc.setTranscriptViewPropeties(properties: messagingView)
    }
}

//MARK: CORE API CALLING ENDS HERE
//MARK: -

struct OrgCredentials {
    var orgId: String
    var orgUrl: String
    var widgetId: String
    var authToken: String

    static let placeholder = OrgCredentials(
        orgId: "<Add org Id>",
        orgUrl: "<Add org url>",
        widgetId: "<Add widget url>",
        authToken: ""
    )

    static let empty = OrgCredentials(orgId: "", orgUrl: "", widgetId: "", authToken: "")

    var isComplete: Bool {
        !orgId.isEmpty && !orgUrl.isEmpty && !widgetId.isEmpty
    }
}

enum OrgCredentialsStore {
    private static let orgIdKey = "orgIdData"
    private static let orgUrlKey = "orgUrlData"
    private static let widgetIdKey = "widgetIdData"
    private static let authTokenAccount = "tokenAuth"

    static func load() -> OrgCredentials {
        let defaults = UserDefaults.standard
        let placeholder = OrgCredentials.placeholder

        let token: String
        if let saved = try? KeychainService.loadToken(for: authTokenAccount), !saved.isEmpty {
            token = saved
        } else {
            token = placeholder.authToken
        }

        return OrgCredentials(
            orgId: defaults.string(forKey: orgIdKey) ?? placeholder.orgId,
            orgUrl: defaults.string(forKey: orgUrlKey) ?? placeholder.orgUrl,
            widgetId: defaults.string(forKey: widgetIdKey) ?? placeholder.widgetId,
            authToken: token
        )
    }

    static func save(_ credentials: OrgCredentials) {
        let defaults = UserDefaults.standard
        defaults.set(credentials.orgId, forKey: orgIdKey)
        defaults.set(credentials.orgUrl, forKey: orgUrlKey)
        defaults.set(credentials.widgetId, forKey: widgetIdKey)
        try? KeychainService.saveToken(credentials.authToken, for: authTokenAccount)
        defaults.set(try? KeychainService.loadToken(for: authTokenAccount), forKey: "authToken")
    }

    static func clear() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: orgIdKey)
        defaults.removeObject(forKey: orgUrlKey)
        defaults.removeObject(forKey: widgetIdKey)
        try? KeychainService.saveToken("", for: authTokenAccount)
    }
}

extension Data {
    var bytes: [UInt8] {
        var byteArray = [UInt8](repeating: 0, count: self.count)
        self.copyBytes(to: &byteArray, count: self.count)
        return byteArray
    }
}

class KeychainService {
    static func saveToken(_ token: String, for account: String) throws {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        // Delete any existing items
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    static func loadToken(for account: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let data = item as? Data, let token = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidItemFormat
        }
        
        return token
    }
    
    enum KeychainError: Error {
        case unhandledError(status: OSStatus)
        case invalidItemFormat
    }
}
