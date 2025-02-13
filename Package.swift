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
            targets: ["ContactCenterMessagingSDK-ios"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microsoft/AdaptiveCards.git", branch: "master")
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
            name: "ContactCenterMessagingSDK-ios",
            dependencies: [
                "ContactCenterMessagingSDK",
                "ContactCenterMessagingWidget",
                "OmnichannelChatSDK",
                .product(name: "AdaptiveCards", package: "AdaptiveCards")
            ]),
    ]
)
