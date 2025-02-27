# Dynamics 365 Contact Center - Messaging SDK - iOS

> ⚠️ The software is available as a Public Preview with release support for select Microsoft
partners and customers. To receive support for your release, contact CC-Mobile-Preview@microsoft.com 
with your release date and plans. Customers must have an agreement with the Contact Center team
to guarantee timely support during the Preview period.

## Table of Contents

  * [About](#about)
  * [Installation](#installation)
    + [Pre-Requisites](#pre-requisites)
    + [Method One: Manual Integration](#method-one-manual-integration)
    + [Method Two: Cocoapods](#method-two-cocoapods)
    + [Instructions for Using the Chat Feature in the Sample App](#instructions-for-using-the-chat-feature-in-the-sample-app)
  * [Initializing](#initializing)
    + [InitOmnichannelChatSDK API](#initomnichannelchatsdk-api)
  * [Contributing](#contributing)
  * [Trademarks](#trademarks)

## About

The Dynamics 365 Contact Center Messaging SDK enables developers to add 
[Dynamics 365 Contact Center](https://www.microsoft.com/en-us/dynamics-365/products/contact-center)'s
messaging to their branded mobile applications.

This SDK contains two components:

* **Messaging Widget**: A pre-built, fully featured native messaging interface that the 
customer can use wholesale and easily customize to match their branding. The 
widget is already integrated with Omnichannel and customers that opt to use it do 
not need to interact with the Core Messaging Functions for almost all of the 
messaging lifecycle. 
* **Core Messaging Framework**: Enables a developer to build their own messaging 
interface. This is a full set of functions that interact with the Omnichannel 
Messaging APIs which the customer can connect with an existing or new interface in 
their branded app.

For most messaging programs, **we recommend the use of our out of the box Messaging Widget**:

* Provides messaging with the least amount of development effort
* Configurable look, feel, and customization options so the widget can be branded easily
to match your app. The available options are based on what is available with our Web
Live Chat Widget (LCW), so developers that are familiar with our web application
can quickly match their existing program

If there are any customizations you need that aren't available in our product, please
don't hesitate to reach out to us at CC-Mobile-Preview@microsoft.com and we'll add them
to our roadmap.

## Installation
### Pre-Requisites

*	Dynamics 365 Contact Center License
    *	Provisioned test organization, retrieving these variables:
        *	orgID
        *	orgURL
    * Provisioned Chat Channel & Live Chat Widget configuration, retrieving these variables:
        *	widgetID/applicationID
        *	For reference, see:
            * [Configure a chat widget | Microsoft Learn](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/add-chat-widget)
            * [Embed chat widget in your website or portal | Microsoft Learn](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/embed-chat-widget-portal)
* Application deployment target minimum of iOS 14 or above
* XCode 15 and above
* Cocoapods

### Method One: Manual Integration
1. Clone the repository ContactCenterMessagingSDK-ios.
2. Go to the root folder of ContactCenterMessagingApp.
3. Open the Podfile and either remove or comment out the following lines to prevent CocoaPods from automatically adding the SDK:
    ```
    $sdkVersion = 'v1.0.0' 
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

### Method Two: Cocoapods
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

## Initializing
### InitOmnichannelChatSDK API
You need to initialize the Omnichannel SDK with your omnichannel credentials and desired settings before doing any other operations. You can do this via InitOmnichannelChatSDK API. You can call this api using LiveChatMessaging class from ContactCenterMessagingSDK framework, either at startup, or at the desired point in your application flow. 

omniChannelConfig is mandatory. This includes your org details and other optional parameters that dictate chat behavior and what details are passed to the Agent. A detailed list of available parameters is below.

**API**:
```objc
public func initialize(omniChannelConfig:LCWOmniChannelConfigRequest,
                       chatSDKconfig: LCWChatSDKConfigRequest?,
                       initializeChatConfig:LCWInitializeParamsRequest?,
                       authToken: String?, /// For customer authentication -- see "Authentication"
                       environment: String /// Configure the current environment setting, such as test, production, etc.
                      )
```

**Builders**:
```objc
public struct LCWOmniChannelConfigRequest { /// Use this builder for omnichannel configuration, which includes various settings. Required.
    public let orgId: String? /// Provide the Microsoft-supplied organization ID to identify your organization.
    public let orgUrl: String? /// Enter the Microsoft-supplied organization URL to identify your org.
    public let widgetId: String? /// Use the Microsoft-provided widget ID to identify your omnichannel chat.
}

public struct LCWChatSDKConfigRequest { /// Used to configure the chat, including several parameters. Optional.
    public var dataMasking: LCWDataMaskingSDKConfig? /// Used to input settings for data masking 
    public var telemetry: LCWTelemetrySDKConfig? /// Used to enable or disable telemetry tracking for chat.
    public var persistentChat: LCWPersistentChatConfig? /// Used to enable or disable persistent chat
    public var chatReconnect: LCWChatReconnectConfig? /// Used to turn chat reconnect functionality on or off
}

public struct LCWDataMaskingSDKConfig {
    public var disable: Bool = true /// This flag controls enabling or disabling data masking. Default value is true, disabled
    public var maskingCharacter: String? /// Define masking regex characters
}

public struct LCWTelemetrySDKConfig {
    public var disable: Bool? = false /// This flag controls telemetry activation. Default value is false, disabled.
}

public struct LCWPersistentChatConfig {
    public var disable: Bool = false /// This flag controls persistent chat, which is false by default.
    public var tokenUpdateTime: String? /// This parameter lets you set the token update time.
}

public struct LCWChatReconnectConfig {
    public var disable: Bool = true /// This flag enables or disables chat reconnection. The default value is true, disabled
}

public struct LCWInitializeParamsRequest { /// Used to provide omnichannel chat SDK initialization parameters, optional
     public let sendCacheHeaders: Bool? /// A Boolean value set true to send cache headers with the response, particularly for browsers
     public let useRuntimeCache: Bool? /// A Boolean is used to control whether the runtime cache is utilized during the chat session. When useRuntimeCache is set to true, it allows the system to use cached data for faster performance and reduced latency, particularly for browsers
}
```
## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
