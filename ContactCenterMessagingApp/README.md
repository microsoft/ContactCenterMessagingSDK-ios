# ContactCenterMessagingApp

** HOW TO RUN APPLICATION **

Manual Integration:
1. Clone the repository.
2. Open the terminal and change directory to the root folder of ContactCenterMessagingApp.
3. Open the Podfile and comment out the following line to prevent CocoaPods from automatically adding the SDK: 
    ```
    $sdkVersion = 'v0.0.1-beta.17' 
    pod 'ContactCenterMessagingSDK', :podspec => 'https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases/download/' + $sdkVersion + '/ContactCenterMessagingSDK-ios.podspec'
    ```
4. Install pods : command : pod install 
5. Manually download the xcframeworks from releases section for desired version and add into to the root folder of ContactCenterMessagingApp. https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases
6. Open ContactCenterMessagingApp.xcworkspace.
7. Import the downloaded xcframeworks into the project.
8. Add credentials OrgID, OrgURL and WidgetId into ViewController class.
9. Run the application.

Integration through Cocoapods:
1. Clone the repository.
2. Open the terminal and change directory to the root folder of ContactCenterMessagingApp.
3. Open podfile and update ContactCenterMessagingSDK version.
4. Install pods : command : pod install
5. Open ContactCenterMessagingApp.xcworkspace.
6. Add credentials OrgID, OrgURL and WidgetId into ViewController class.
7. Run the application.
