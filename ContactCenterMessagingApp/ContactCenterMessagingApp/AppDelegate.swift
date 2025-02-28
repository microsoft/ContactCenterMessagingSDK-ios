//
//  AppDelegate.swift
//  ContactCenterMessagingApp
//
//  Created by Microsoft on 03/06/24.
//  Copyright © 2024 Microsoft. All rights reserved.
//

import UIKit
import UserNotifications
import ContactCenterMessagingSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Request notification authorization
        registerForPushNotifications(application: application)
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Handle successful registration for remote notifications
   func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
       print("Device token:(token) :",token)
       // Send the device token to your server for push notification handling
       UserDefaults.standard.set(token, forKey: "FirebaseFCMToken")
       UserDefaults.standard.synchronize()

   }
   // Handle unsuccessful registration for remote notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \\(error.localizedDescription)")
    }
   
    // Handle notification when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle the notification presentation here
        completionHandler([.banner,.badge,.list])
    }
    
    private func registerForPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {
            (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    // Handle receipt of remote notification while the app is in the background
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle the received remote notification here
        // Print the notification payload
        print("Received remote notification: \(userInfo)")
        // Process the notification content
       if let aps = userInfo["aps"] as? [String: Any], let alert = aps["alert"] as? String {
           // Extract information from the notification payload
           print("Notification message: \(alert)")
       }
       // Indicate the result of the background fetch to the system
       completionHandler(UIBackgroundFetchResult.newData)
   }
}
