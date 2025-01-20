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
    
    private var orgIdData = "<Add org Id>"
    private var orgUrlData = "<Add org url>"
    private var widgetIdData = "<Add widget url>"
    private var authToken = ""
   
    private var orgIdDataFinal = ""
    private var orgUrlDataFinal = ""
    private var widgetIdDataFinal = ""
    private var authTokenFinal = ""
    
    private var liveChatMessagingVC: LiveChatMessagingViewController!
    
    private let blueOCStandardColor = UIColor(red: 47/255.0, green: 90/255.0, blue: 146/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        orgIdTextField.delegate = self
        orgUrlTextField.delegate = self
        widgetIdTextField.delegate = self
        viewAddDetails.layer.borderColor = blueOCStandardColor.cgColor
        viewAddDetails.layer.borderWidth = 0.5
        viewAddDetails.layer.cornerRadius = 5
        
        btnStartChat.layer.cornerRadius = 5
        btnStartChat.setTitle("Start Chat", for: .normal)
        
        if let orgID = UserDefaults.standard.value(forKey: "orgIdData") as? String {
            orgIdTextField.text = orgID
        } else {
            orgIdTextField.text = orgIdData
        }
        orgIdDataFinal = orgIdTextField.text ?? ""
        
        if let orgUrl = UserDefaults.standard.value(forKey: "orgUrlData") as? String {
            orgUrlTextField.text = orgUrl
        } else {
            orgUrlTextField.text = orgUrlData
        }
        orgUrlDataFinal = orgUrlTextField.text ?? ""
        
        if let widgetId = UserDefaults.standard.value(forKey: "widgetIdData") as? String {
            widgetIdTextField.text = widgetId
        } else {
            widgetIdTextField.text = widgetIdData
        }
        widgetIdDataFinal = widgetIdTextField.text ?? ""

        if let savedToken = try? KeychainService.loadToken(for: "tokenAuth"), !savedToken.isEmpty {
            authTokenTextField.text = savedToken
        } else {
            authTokenTextField.text = authToken
        }
        authTokenFinal = authTokenTextField.text ?? ""
        
        setProdAPI();
        btnStartChat.backgroundColor = .lightGray
        btnStartChat.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LiveChatMessaging.shared.initOmnichannelChatSDK(self) { [self] success, error in
            if success != nil {
                checkChatGoingOn { isChatGoingOn in
                    DispatchQueue.main.async { [self] in
                        isChatGoingOn ? btnStartChat.setTitle("Restart Chat", for: .normal) : btnStartChat.setTitle("Start Chat", for: .normal)
                        btnStartChat.isEnabled = true
                        btnStartChat.backgroundColor = UIColor(red: 47/255.0, green: 90/255.0, blue: 146/255.0, alpha: 1.0)
                    }
                }
            } else {
                btnStartChat.isEnabled = true
                btnStartChat.backgroundColor = UIColor(red: 47/255.0, green: 90/255.0, blue: 146/255.0, alpha: 1.0)
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func actionBtnStartChat(_ sender: Any) {
        
        if (orgIdTextField.text ?? "").isEmpty || (orgUrlTextField.text ?? "").isEmpty || (widgetIdTextField.text ?? "").isEmpty {
            showError()
            return
        }

        UserDefaults.standard.set(orgIdTextField.text ?? "", forKey: "orgIdData")
        UserDefaults.standard.set(orgUrlTextField.text ?? "", forKey: "orgUrlData")
        UserDefaults.standard.set(widgetIdTextField.text ?? "", forKey: "widgetIdData")
        try? KeychainService.saveToken((authTokenTextField.text ?? ""), for: "tokenAuth")
        UserDefaults.standard.set(try? KeychainService.loadToken(for: "tokenAuth"), forKey: "authToken")

        setProdAPI()
        
        if liveChatMessagingVC == nil {
            liveChatMessagingVC = launchMessagingViewController(delegate: self)
        }
        liveChatMessagingVC.modalPresentationStyle = .fullScreen
        self.present(liveChatMessagingVC, animated: true, completion: nil)
    }
    
    func setProdAPI() {
        let engage = LCWOmniChannelConfigRequest(orgId: orgIdDataFinal, orgUrl: orgUrlDataFinal, widgetId: widgetIdDataFinal)
        LiveChatMessaging.shared.initialize(omniChannelConfig: engage, chatSDKconfig: LCWChatSDKConfigRequest(telemetry: LCWTelemetrySDKConfig(disable: true),persistentChat: LCWPersistentChatConfig(disable: false), chatReconnect: LCWChatReconnectConfig(disable: false)), initializeChatConfig: nil, authToken:authToken, environment: "test")
    }
    
    func showError() {
        let ac = UIAlertController(title: "Alert!", message: "Please add all details.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in}
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    @IBAction func actionClearChat(_ sender: Any) {
        LiveChatMessaging.shared.resetAllData()
        widgetIdTextField.text = ""
        orgUrlTextField.text = ""
        orgIdTextField.text = ""
        authTokenTextField.text = ""
        
        authTokenFinal = ""
        orgIdDataFinal = ""
        orgUrlDataFinal = ""
        widgetIdDataFinal = ""
        
        btnStartChat.setTitle("Start Chat", for: .normal)
        
        UserDefaults.standard.removeObject(forKey: "orgIdData")
        UserDefaults.standard.removeObject(forKey: "orgUrlData")
        UserDefaults.standard.removeObject(forKey: "widgetIdData")
        UserDefaults.standard.removeObject(forKey: "tokenAuth")
    }
    
    @IBAction func actionAddDefaultCred(_ sender: Any) {
        LiveChatMessaging.shared.resetAllData()
        
        orgIdTextField.text = orgIdData
        orgUrlTextField.text = orgUrlData
        widgetIdTextField.text = widgetIdData
        authTokenTextField.text = authToken
        
        authTokenFinal = orgIdData
        orgIdDataFinal = orgUrlData
        orgUrlDataFinal = widgetIdData
        widgetIdDataFinal = authToken
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

//MARK: CORE API CALLING ENDS HERE
//MARK: -

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
