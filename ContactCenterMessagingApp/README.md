# ContactCenterMessagingApp

** HOW TO RUN APPLICATION **

**Manual Integration 1: Add 'Adaptivecards' using pods.**

1. Clone the repository ContactCenterMessagingSDK-ios.
2. Go to the root folder of ContactCenterMessagingApp.
3. Open the Podfile and either remove or comment out the following lines to prevent CocoaPods from automatically adding the SDK:
    ```
    $sdkVersion = 'v0.0.2' 
    pod 'ContactCenterMessagingSDK', :podspec => 'https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases/download/' + $sdkVersion + '/ContactCenterMessagingSDK-ios.podspec'
    ```
4. Open the terminal and navigate to the root directory of the ContactCenterMessagingApp to install the pods for the Adaptivecards dependency. Execute the following command in the terminal.
command : pod install 
5. Manually download the xcframeworks from releases section for desired version and add into to the root folder of ContactCenterMessagingApp. https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases
6. Open ContactCenterMessagingApp.xcworkspace in xcode.
7. Add the downloaded xcframeworks into the project. For adding XCframeworks 
Click on 'ContactCenterMessagingApp' -> Select 'Targets' -> Select 'General' -> Open 'Frameworks, Library and Embedded Content' -> Click on '+' icon -> Click on 'Add Other' -> Select 'Add Files' -> Select following xcframeworks
        a. ContactCenterMessagingSDK.xcframework
        b. ContactCenterMessagingWidget.xcframework
        c. OmnichannelChatSDK.xcframework
9. Open ViewController class and add omnichannel credentials OrgID, OrgURL and WidgetId.
10. Clean build and run the application.

**Manual Integration 2: Add 'Adaptivecards' manually.**
1. Clone the repository ContactCenterMessagingSDK-ios.
2. Manually download the xcframeworks from releases section for desired version and add into to the root folder of ContactCenterMessagingApp. https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases
3. Manually download the zips for Adaptivecards from https://github.com/microsoft/ContactCenterMessagingSDK-ios/tree/users/mugdham/adaptiveCardPlatform/Sources/Adaptivecards
Download following .zip files
   * Adaptivecards_XCFrameworks.zip
   * FluentUI.xcframework.zip
   * CocoaLumberjack.xcframework.zip
   * SVGKit.xcframework.zip
Unzip all frameworks and add into the root folder of ContactCenterMessagingApp.
5. Go to the root folder of ContactCenterMessagingApp.
6. Open ContactCenterMessagingApp.xcodeproj in xcode.
7. Add the downloaded ContactCenterMessaging & Adaptivecard xcframeworks into the project. For adding XCframeworks 
Click on 'ContactCenterMessagingApp' -> Select 'Targets' -> Select 'General' -> Open 'Frameworks, Library and Embedded Content' -> Click on '+' icon -> Click on 'Add Other' -> Select 'Add Files' -> Select following xcframeworks
        a. ContactCenterMessagingSDK.xcframework
        b. ContactCenterMessagingWidget.xcframework
        c. OmnichannelChatSDK.xcframework
        d. Adaptivecards_XCFrameworks
        e. FluentUI.xcframework
        f. CocoaLumberjack.xcframework
        g. SVGKit.xcframework
8. Kindly check all frameworks are ‘Embed and Sign'
9. Open ViewController class and add omnichannel credentials OrgID, OrgURL and WidgetId.
10. Clean build and run the application.

**Integration through Cocoapods:**
1. Clone the repository ContactCenterMessagingSDK-ios.
2. Go to the root folder of ContactCenterMessagingApp.
3. Open podfile and update ContactCenterMessagingSDK version.
4. Open the terminal and navigate to the root directory of the ContactCenterMessagingApp to install the pods for the Adaptivecards dependency & ContactCenterMessagingSDKs. Execute the following command in the terminal.
command : pod install
5. Open ContactCenterMessagingApp.xcworkspace in xcode.
6. Open ViewController class and add omnichannel credentials OrgID, OrgURL and WidgetId.
7. Clean build and run the application.


### Instructions for Using the Chat Feature in the Sample App:
1. Paste Your Script (taken from the Chat Workstream Page) or Add the Required Information:

In your app’s landing screen, you will find input fields where you need to enter:
orgId
orgUrl
widgetId

Alternatively, you can paste a script, which will automatically fill in these details for you.

2. Click on the "Let's Chat" Button:
Once you've entered the required information (or pasted the script), look for a button labeled "Let's Chat" on your screen.
Tap on this button to initiate the chat. The app will connect to the specified chat system and load the widget for you.

3.Start Interacting with the Chat:
After clicking the button, you will see the chat interface appear on the screen.
You can now type messages, send media, or interact with the chat in real-time. 
The app will allow you to communicate with customer support or any automated services available.

