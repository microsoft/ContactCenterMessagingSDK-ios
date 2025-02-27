# Dynamics 365 Contact Center - Messaging SDK - iOS

> ⚠️ The software is available as a Public Preview with release support for select Microsoft
partners and customers. To receive support for your release, contact CC-Mobile-Preview@microsoft.com 
with your release date and plans. Customers must have an agreement with the Contact Center team
to guarantee timely support during the Preview period.

## Sample Application 
* You can refer to the sample application from here
[ContactCenterMessagingApp](https://github.com/microsoft/ContactCenterMessagingSDK-ios/tree/main/ContactCenterMessagingApp).

## Table of Contents

  * [About](#about)
  * [Installation](#installation)
    + [Pre-Requisites](#pre-requisites)
    + [Method One: Manual Integration](#method-one-manual-integration)
    + [Method Two: Cocoapods](#method-two-cocoapods)
    + [Instructions for Using the Chat Feature in the Sample App](#instructions-for-using-the-chat-feature-in-the-sample-app)
  * [Initializing](#initializing)
    + [InitOmnichannelChatSDK API](#initomnichannelchatsdk-api)
    + [Authentication](#authentication)
  * [Messaging Widget](#messaging-widget)
  * [Core Messaging Framework](#core-messaging-framework)
    + [Get Success and Error Responses](#get-success-and-error-responses)
    + [initOmnichannelChatSDK](#initomnichannelchatsdk)
    + [getAgentAvailability](#getagentavailability)
    + [onNewMessage](#onnewmessage)
    + [startChat](#startchat)
    + [getAgentTypingStatus](#getagenttypingstatus)
    + [sendCustomerTyping](#sendcustomertyping)
    + [onAgentEndSession](#onagentendsession)
    + [getLCWLiveChatConfig](#getlcwlivechatconfig)
    + [getPreChatSurvey](#getprechatsurvey)
    + [sendMessage](#sendmessage)
    + [getAllMessages](#getallmessages)
    + [getLiveChatTranscript](#getlivechattranscript)
    + [getConversationDetails](#getconversationdetails)
    + [getDataMaskingRules](#getdatamaskingrules)
    + [uploadFileAttachment](#uploadfileattachment)
    + [downloadFileAttachment](#downloadfileattachment)
    + [getChatToken](#getchattoken)
    + [emailTranscriptCall](#emailtranscriptcall)
    + [endOCSDKChat](#endocsdkchat)
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
1. Go to the root folder of your app.
2. Create podfile using command: pod install
3. Open the Podfile and add 'AdaptiveCards' dependency. You can refer [podfile](https://github.com/microsoft/ContactCenterMessagingSDK-ios/blob/main/ContactCenterMessagingApp/Podfile) from sample app. 

```pod 'AdaptiveCards'```

5. Open the terminal and navigate to the root directory of your app to install the pods. Execute the following command in the terminal.
command : pod install 
6. Manually download the xcframeworks from releases[https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases] section for desired version and add to the root folder of your app.
7. Open .xcworkspace in xcode.
8. Add the downloaded xcframeworks into your project. For adding XCframeworks 
Click on your project -> Select 'Targets' -> Select 'General' -> Open 'Frameworks, Library and Embedded Content' -> Click on '+' icon -> Click on 'Add Other' -> Select 'Add Files' -> Select following xcframeworks
        a. ContactCenterMessagingSDK.xcframework
        b. ContactCenterMessagingWidget.xcframework
        c. OmnichannelChatSDK.xcframework
9. Clean build and run the application.

### Method Two: Cocoapods
1. Go to the root folder of your app.
2. Create podfile using command: pod install
3. Open the Podfile. Add 'ContactCenterMessagingSDK' & 'AdaptiveCards' dependency. You can refer [podfile](https://github.com/microsoft/ContactCenterMessagingSDK-ios/blob/main/ContactCenterMessagingApp/Podfile) from sample app.
   
 ```$sdkVersion = '<ContactCenterMessagingSDK_Version>'
    pod 'ContactCenterMessagingSDK', :podspec =>  'https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases/download/' + $sdkVersion + '/ContactCenterMessagingSDK-ios.podspec'
    pod 'AdaptiveCards'
 ```
4. Open the terminal and navigate to the root directory of your app to install the pods. Execute the following command in the terminal.
command : pod install
5. Open .xcworkspace in xcode.
6. Clean build and run the application.

## Initializing
### Initialize ContactCenterMessagingSDK
You need to initialize the Omnichannel SDK with your omnichannel credentials and desired settings before doing any other operations. You can do this via initialize API. You can call this api using LiveChatMessaging class from ContactCenterMessagingSDK framework, either at startup, or at the desired point in your application flow. 

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
### Authentication

Dynamics Contact Center always recommends using persistent chat for mobile, which requires customer 
authentication. You identify the customer during initialization by providing an auth token containing 
an identifier such as a Dynamics Record ID, with the token signed by your identity provider.

Details on setting up a token are available here: https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/create-chat-auth-settings

## Messaging Widget
Customizations available in the out of the box messaging widget are documented here:

[iOS Widget Customizations](iOS_Widget_Customizations.pdf)

## Core Messaging Framework 
This section describes the messaging lifecycle functions in the SDK.

### Get Success and Error Responses

Most APIs use LCWResponse for success and error responses. To access them, call successResponse.getResponse() for success responses in [String: Any]? format and errorObj.getErrorMessage() for error messages. 

For errors in sendMessages or uploadFileAttachment, identify the unsent message or failed upload via error?.getErrorProperties(), which includes the id from the request.

```objc
@objc public class LCWResponse : NSObject {
    public func getResponse() -> [String : Any]?
     public func getErrorMessage() -> String?
    public func getErrorProperties() -> [String : Any]?
}
```

### initOmnichannelChatSDK
This API is used to initialize the OmnichannelChatSDK. It requires a view controller object and provides a completion handler to handle the response.
#### Method
```objc
public func initOmnichannelChatSDK(_ viewController: UIViewController, _ completionHandler: ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `viewController`: A UIViewController object that represents the view controller where the chat SDK will be initialized.
  * `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
    * `success`: An optional LCWResponse object that contains the details of the successful response.
    * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
let viewController = UIViewController()
LiveChatMessaging.shared.initOmnichannelChatSDK(viewController) {(success, error) in
    if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print("Initialization successful: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```


### getAgentAvailability
This API is used to check the availability of agents. It takes optional parameters for the request and provides a completion handler to handle the response.
#### Method
```objc
public func getAgentAvailability(_ optionalParams: LCWAgentAvailabilityRequest? = nil, _ completionHandler: @escaping ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void))
```
#### Parameters
* `optionalParams`: An optional parameter of type LCWAgentAvailabilityRequest. This parameter can be used to pass additional request details. All parameters are optional in LCWAgentAvailabilityRequest.
  * `preChatResponse`: A dictionary containing pre-chat response.
  * `customContext`: A dictionary containing custom context information.
  * `browser`: A string representing the browser being used. particularly for browsers.
  * `os`: A string representing the operating system being used.
  * `locale`: A string representing the locale.
  * `device`: A string representing the device being used.
  * `initContext`: A dictionary containing initialization context information.
  * `reconnectId`: A string representing the reconnect ID.
  * `portalContactId`: A string representing the portal contact ID.
* `completionHandler`: A closure that is called when the API call completes. It has two parameters:
  * `success`: A closure that is called when the API call completes. It has two parameters:
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
let optionalParams = LCWAgentAvailabilityRequest(
    preChatResponse: ["question1": "answer1"],
    customContext: ["key": "value"],
    browser: "",
    os: "iOS",
    locale: "en-US",
    device: "iPhone",
    initContext: ["contextKey": "contextValue"],
    reconnectId: "12345",
    portalContactId: "67890"
)

LiveChatMessaging.shared.getAgentAvailability(optionalParams) { (success, error) in
     if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        	// Handle success
        	print(" Agent availability: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### onNewMessage
This API is used to handle new incoming messages. It takes parameters for the request and provides a completion block to handle the response.
#### Method
```objc
public func onNewMessage(_ params: LCWGetMessageRequest, completionBlock: @escaping ((_ success: LCWGetMessageResponse?, _ error: LCWResponse?) -> Void))  
```
#### Parameters
* `params`: A parameter of type LCWGetMessageRequest. This parameter contains the details of the message request.
  * `rehydrate`: A boolean value indicating whether to rehydrate previous messages from existing conversation. The default value is false.
* `completionBlock`: A closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWGetMessageResponse object that contains the details of the successful response
  * `error`: An optional LCWResponse object that contains the details of the error response
#### Example
```objc
let messageRequest = LCWGetMessageRequest(rehydrate: true)
LiveChatMessaging.shared.onNewMessage(messageRequest) { (success, error) in
  if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" New message received: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```



### startChat
This API is used to start a chat session. It takes optional parameters for the request and provides a completion handler to handle the response.
#### Method
```objc
public func startChat(_ optionalParams: LCWStartChatRequest? = nil, _ completionHandler: @escaping ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void))  
```
#### Parameters
* `optionalParams`: An optional parameter of type LCWStartChatRequest. This parameter can be used to pass additional request details. All parameters in LCWStartChatRequest are optional.
  * `liveChatContext`: A dictionary containing the live chat context.
  * `preChatResponse`: A dictionary containing pre-chat responses.
  * `customContext`: A dictionary containing custom context information.
  * `browser`: A string representing the browser being used (the widget will report "App", we recommend using the same value)
  * `os`: A string representing the operating system being used.
  * `locale`: A string representing the locale.
  * `device`: A string representing the device being used.
  * `initContext`: An optional parameter of type LCWInitializeParamsRequest containing initialization context information.
    * `sendCacheHeaders`: A Boolean value set true to send cache headers with the response, particularly for browsers. 
    * `useRuntimeCache`: A Boolean is used to control whether the runtime cache is utilized during the chat session. When useRuntimeCache is set to true, it allows the system to use cached data for faster performance and reduced latency, particularly for browsers.
  * `reconnectId`: A string representing the reconnect ID.
  * `isProactiveChat`: A boolean value indicating whether the chat is proactive.
  * `latitude`: A string representing the latitude.
  * `longitude`: A string representing the longitude.
  * `portalContactId`: A string representing the portal contact ID.
* `completionHandler`: A closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
let startChatRequest = LCWStartChatRequest(
    liveChatContext: ["contextKey": "contextValue"],
    preChatResponse: ["question1": "answer1"],
    customContext: ["key": "value"],
    browser: "Chrome",
    os: "iOS",
    locale: "en-US",
    device: "iPhone",
    initContext: nil,
    reconnectId: nil,
    isProactiveChat: true,
    latitude: "37.7749",
    longitude: "-122.4194",
    portalContactId: "67890"
)

LiveChatMessaging.shared.startChat(startChatRequest) { (success, error) in
       if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Chat started successfully: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }

}
```


### getAgentTypingStatus
This API is used to check the typing status of an agent. It provides a completion handler to handle the response.
#### Method
```objc
public func getAgentTypingStatus(completionHandler: @escaping ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void))  
```
#### Parameters
* `completionHandler`: A closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
LiveChatMessaging.shared.getAgentTypingStatus { (success, error) in

  if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Agent typing status: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }

}
```



### sendCustomerTyping
This API is used to send the typing status of a customer. It provides a completion handler to handle the response.
#### Method
```objc
public func sendCustomerTyping(completionHandler: ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void)?)  
```
#### Parameters
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.

#### Example
```objc
LiveChatMessaging.shared.sendCustomerTyping { (success, error) in
        if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Customer typing status sent: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```




### onAgentEndSession
This API is used to handle the event when an agent ends a chat session. It provides a completion handler to handle the response.
#### Method
```objc
public func onAgentEndSession(completionHandler: ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void)?)  
```
#### Parameters
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
LiveChatMessaging.shared.onAgentEndSession { (success, error) in
         if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Agent ended session: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```



### getLCWLiveChatConfig
This API is used to retrieve the live chat configuration. It takes optional parameters for the request and provides a completion handler to handle the response. 
The ChatConfig contains many parameters defined in the Customer Service Admin Center.
#### Method
```objc
public func getLCWLiveChatConfig(_ optionalParams: LCWInitializeParamsRequest, completionHandler: ((_ response: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `optionalParams`: A parameter of type LCWInitializeParamsRequest. This parameter can be used to pass additional request details.
  * `sendCacheHeaders`: A Boolean value set true to send cache headers with the response, particularly for browsers.
  * `useRuntimeCache`: A Boolean is used to control whether the runtime cache is utilized during the chat session. When useRuntimeCache is set to true, it allows the system to use cached data for faster performance and reduced latency, particularly for browsers.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWInitializeParamsRequest: Codable {
     public let sendCacheHeaders: Bool?
     public let useRuntimeCache: Bool?
     
     public init(sendCacheHeaders: Bool?, useRuntimeCache: Bool?) {
         self.sendCacheHeaders = sendCacheHeaders
         self.useRuntimeCache = useRuntimeCache
     }
}

let initParams = LCWInitializeParamsRequest(sendCacheHeaders: true, useRuntimeCache: false)
LiveChatMessaging.shared.getLCWLiveChatConfig(initParams) { (response, error) in
           if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Live chat configuration: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### getPreChatSurvey
This API is used to retrieve the pre-chat survey json. It provides a completion handler to handle the response.
#### Method
```objc
public func getPreChatSurvey(completionHandler: ((_ response: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
LiveChatMessaging.shared.getPreChatSurvey { (response, error) in
          if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Pre-chat survey retrieved: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### sendMessage
This API is used to send a message. It takes parameters for the message, a unique identifier, and provides a completion handler to handle the response.
#### Method
```objc
public func sendMessage(params: LCWSendMessageRequest, id: String, _ completionHandler: ((_ response: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `params`: A parameter of type LCWSendMessageRequest. This parameter contains the details of the message to be sent.
  * `content`: A string representing the content of the message.
  * `tags`: An optional array of strings representing tags associated with the message.
  * `timestamp`: An optional date representing the timestamp of the message.
  * `metadata`: An optional dictionary containing additional metadata for the message.
* `id`: A string representing a unique identifier given by the user.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWSendMessageRequest: Codable {
    public var content: String = ""
    public var tags: [String]?
    public var timestamp: Date?
    public var metadata: [String: Any]?
}

let messageRequest = LCWSendMessageRequest(
    content: "Hello, how can I help you?",
    tags: ["FromCustomer"],
    timestamp: Date(),
    metadata: ["key": "value"]
)
let uniqueId = "12345"

LiveChatMessaging.shared.sendMessage(params: messageRequest, id: uniqueId) { (response, error) in
       if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Message sent successfully: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### getAllMessages
This API is used to retrieve all messages of chat. It provides a completion handler to handle the response.
#### Method
```objc
public func getAllMessages(completionHandler: @escaping ((_ success: [LCWGetMessageResponse]?, _ error: LCWResponse?) -> Void))
```
#### Parameters
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
LiveChatMessaging.shared.getAllMessages { (success, error) in
      if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Message: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}

```

### getLiveChatTranscript
This API is used to retrieve the live chat transcript. It takes optional parameters for the request and provides a completion handler to handle the response.
#### Method
```objc
public func getLiveChatTranscript(_ optionalParams: LCWLiveChatContextRequest?, completionHandler: @escaping ((_ success: [LCWGetMessageResponse]?, _ error: LCWResponse?) -> Void))
```
#### Parameters
* `optionalParams`: An optional parameter of type LCWLiveChatContextRequest. This parameter can be used to pass additional request details.
  * `liveChatContext`: A dictionary containing the live chat context.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWLiveChatContextRequest {
    public var liveChatContext: [String: Any]?
}
 
let chatContextRequest = LCWLiveChatContextRequest(liveChatContext: ["contextKey": "contextValue"])

LiveChatMessaging.shared.getLiveChatTranscript(chatContextRequest) { (success, error) in
      if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Messages transcript: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}

### getConversationDetails
This API is used to retrieve the details of a conversation. It takes optional parameters for the request and provides a completion handler to handle the response.
#### Method
```objc
public func getConversationDetails(_ optionalParams: LCWLiveChatContextRequest? = nil, completionHandler: @escaping ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void))
```
#### Parameters
* `optionalParams`: An optional parameter of type LCWLiveChatContextRequest. This parameter can be used to pass additional request details.
  * `liveChatContext`: A dictionary containing the live chat context.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWLiveChatContextRequest: Codable {
    public var liveChatContext: [String: Any]?
}
 
let conversationContextRequest = LCWLiveChatContextRequest(liveChatContext: ["contextKey": "contextValue"])

LiveChatMessaging.shared.getConversationDetails(conversationContextRequest) { (success, error) in
          if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Conversation details: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```


### getDataMaskingRules
This API is used to retrieve the data masking rules. It provides a completion handler to handle the response.
#### Method
```objc
public func getDataMaskingRules(completionHandler: ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
LiveChatMessaging.shared.getDataMaskingRules { (success, error) in
        if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Data masking rules retrieved: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### uploadFileAttachment
This API is used to upload a file attachment. It takes parameters for the file information, a unique identifier, and provides a completion handler to handle the response.
#### Method
```objc
public func uploadFileAttachment(params: LCWFileInfoRequest, id: String = "", completionHandler: ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `params`: A parameter of type LCWFileInfoRequest. This parameter contains the details of the file to be uploaded.
  * `data`: A string representing the file data.
  * `name`: A string representing the file name.
  * `size`: A double representing the file size.
  * `type`: A string representing the file type.
* `id`: An optional closure that is called when the API call completes. It has two parameters:
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWFileInfoRequest: Codable {
    public var data: String
    public var name: String
    public var size: Double
    public var type: String
}

let fileInfoRequest = LCWFileInfoRequest(
    data: "base64EncodedString",
    name: "example.txt",
    size: 1024.0,
    type: "text/plain"
)
let uniqueId = "12345"

LiveChatMessaging.shared.uploadFileAttachment(params: fileInfoRequest, id: uniqueId) { (success, error) in
    if let successResponse = success {
        // Handle success
        print("File uploaded successfully: \(successResponse)")
    } else if let errorResponse = error {
        // Handle error
        print("Error: \(errorResponse)")
    }
}
```

### downloadFileAttachment
This API is used to download a file attachment. It takes parameters for the file metadata and provides a completion handler to handle the response.
#### Method
```objc
public func downloadFileAttachment(params: LCWFileMetadataRequest, completionHandler: ((_ response: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `params`: A parameter of type LCWFileMetadataRequest. This parameter contains the details of the file to be downloaded.
  * `fileSharingProtocolType`: An optional integer representing the file sharing protocol type.
  * `id`: A string representing the file ID.
  * `name`: An optional string representing the file name.
  * `size`: An optional integer representing the file size.
  * `type`: A string representing the file type.
  * `url`: An optional string representing the file URL.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWFileMetadataRequest: Codable {
    public var fileSharingProtocolType: Int64?
    public var id: String
    public var name: String?
    public var size: Int64?
    public var type: String
    public var url: String?
}

let fileMetadataRequest = LCWFileMetadataRequest(
    fileSharingProtocolType: 1,
    id: "file123",
    name: "example.txt",
    size: 1024,
    type: "text/plain",
    url: "https://example.com/file123"
)

LiveChatMessaging.shared.downloadFileAttachment(params: fileMetadataRequest) { (response, error) in
           if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" File downloaded successfully: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### getChatToken
This API is used to retrieve a chat token. It takes optional parameters for the request and provides a completion handler to handle the response.
#### Method
```objc
public func getChatToken(_ optionalParams: LCWGetChatTokenRequest? = nil, completionHandler: ((_ response: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `optionalParams`: An optional parameter of type LCWGetChatTokenRequest. This parameter can be used to pass additional request details.
  * `refreshToken`: A boolean value indicating whether to refresh the token. The default value is false.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWGetChatTokenRequest: Codable {
    public var refreshToken: Bool? = false
}

let chatTokenRequest = LCWGetChatTokenRequest(refreshToken: true)

LiveChatMessaging.shared.getChatToken(chatTokenRequest) { (response, error) in
    
         if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Chat token retrieved: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### emailTranscriptCall
This API is used to email the chat transcript. It takes parameters for the email request, optional live chat context, and provides a completion handler to handle the response.
#### Method
```objc
public func emailTranscriptCall(param: LCWEmailTranscriptRequest, optionalParam: LCWLiveChatContextRequest? = nil, completionHandler: ((_ success: LCWResponse?, _ error: LCWResponse?) -> Void)?)
```
#### Parameters
* `param`: A parameter of type LCWEmailTranscriptRequest. This parameter contains the details of the email request.
  * `attachmentMessage`: A string representing the message to be attached.
  * `emailAddress`: A string representing the email address to send the transcript to.
  * `locale`: An optional string representing the locale.
* `optionalParam`: An optional parameter of type LCWLiveChatContextRequest. This parameter can be used to pass additional live chat context details.
  * `liveChatContext`: A dictionary containing the live chat context.
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
public struct LCWEmailTranscriptRequest: Codable {
    public var attachmentMessage: String
    public var emailAddress: String
    public var locale: String?
}
 
public struct LCWLiveChatContextRequest: Codable {
    public var liveChatContext: [String: Any]?
}
 
let emailRequest = LCWEmailTranscriptRequest(
    attachmentMessage: "Please find the chat transcript attached.",
    emailAddress: "example@example.com",
    locale: "en-US"
)
let liveChatContext = LCWLiveChatContextRequest(liveChatContext: ["contextKey": "contextValue"])

LiveChatMessaging.shared.emailTranscriptCall(param: emailRequest, optionalParam: liveChatContext) { (success, error) in
 
        if let successResponse = success, let dictSuccess = successResponse..getResponse() {
        // Handle success
        print(" Transcript emailed successfully: \(dictSuccess)")
    } else if let errorResponse = error, let errorMsg = errorResponse. getErrorMessage() {
        // Handle error
        print("Error: \(errorMsg)")
    }
}
```

### endOCSDKChat
Ends the current Omnichannel SDK chat session.
#### Method
```objc
public func endOCSDKChat(completionBlock: ((_ success: LCWResponse?, _ error : LCWResponse?) -> Void)?)
```
#### Parameters
* `completionHandler`: An optional closure that is called when the API call completes. It has two parameters:
  * `success`: An optional LCWResponse object that contains the details of the successful response.
  * `error`: An optional LCWResponse object that contains the details of the error response.
#### Example
```objc
 LiveChatMessaging.shared.endOCSDKChat { (success, error) in
    if let successResponse = success {
        // Handle success
    } else if let errorResponse = error {
        // Handle error
    }
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
