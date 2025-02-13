// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ContactCenterMessagingSPM",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ContactCenterMessagingSDKSPM",
            targets: ["ContactCenterMessagingSDKSPM"]),
    ],
    targets: [
        .binaryTarget(
            name: "ContactCenterMessagingSDK",
            path: "./Sources/ContactCenterMessagingSDK.xcframework"),
        .binaryTarget(
            name: "ContactCenterMessagingWidget",
            path: "./Sources/ContactCenterMessagingWidget.xcframework"),
        .binaryTarget(
            name: "OmnichannelChatSDK",
            path: "./Sources/OmnichannelChatSDK.xcframework"),
        .target(
            name: "ContactCenterMessagingSPM",
            dependencies: [
                "ContactCenterMessagingSDK",
                "ContactCenterMessagingWidget",
                "OmnichannelChatSDK"
            ]),
    ]
)
