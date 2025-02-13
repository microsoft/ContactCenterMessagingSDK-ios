// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ContactCenterMessagingSDK-ios",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ContactCenterMessagingSDK-ios",
            targets: ["ContactCenterMessagingSDK-ios", "ContactCenterMessagingSDK", "ContactCenterMessagingWidget","OmnichannelChatSDK"]),
    ],
    targets: [
        .target(
            name: "ContactCenterMessagingSDK-ios"),
        .binaryTarget(
            name: "ContactCenterMessagingSDK",
            path: "./Sources/ContactCenterMessagingSDK.xcframework"),
        .binaryTarget(
            name: "ContactCenterMessagingWidget",
            path: "./Sources/ContactCenterMessagingWidget.xcframework"),
        .binaryTarget(
            name: "OmnichannelChatSDK",
            path: "./Sources/OmnichannelChatSDK.xcframework")
    ]
)

