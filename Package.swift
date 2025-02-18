// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ContactCenterMessagingSDK-ios",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "ContactCenterMessagingSDK-ios",
            targets: ["ContactCenterMessagingSDK-ios"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microsoft/AdaptiveCards.git", from: "2022.12.0")
    ],
    targets: [
        .target(
            name: "ContactCenterMessagingSDK-ios",
            dependencies: [.target(name: "ContactCenterMessagingSDK"),
                           .target(name: "ContactCenterMessagingWidget"),
                           .target(name: "OmnichannelChatSDK"),
                           .product(name: "AdaptiveCards", package: "AdaptiveCards")]),
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
