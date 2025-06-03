# Adaptivecards XCFrameworks (Version: 2.10.1)

** Adaptivecards **

To manually add and successfully build AdaptiveCards into your demo application, you need to integrate the following xcframeworks.

* AdaptiveCards.xcframework
* FluentUI.xcframework
* CocoaLumberjack.xcframework
* SVGKit.xcframework

** HOW TO INTEGRATE IN YOUR APPLICATION **
1. Download and Unzip all xcframeworks from
https://github.com/microsoft/ContactCenterMessagingSDK-ios/tree/main/Sources/Adaptivecards
2. Copy paste all (AdaptiveCards, FluentUI, CocoaLumberjack & SVGKit) xcframeworks into your project root folder.
3. Go to your project -> Targets -> General tab -> Frameworks, Libraries and Embedded content.
4. Click on plus sign -> Select Add others -> Click Add files -> select all four xcframeworks from root.
5. Check all frameworks are ‘Embed and Sign'
6. You can now easily run your application with adaptive cards.
