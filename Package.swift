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
    ], dependencies: [
        .package(url: "https://github.com/microsoft/AdaptiveCards.git", branch: "main")
    ],
    targets: [
        .target(
            name: "ContactCenterMessagingSDK-ios",
            dependencies: ["AdaptiveCards"],
            exclude: ["ContactCenterMessagingApp"]),
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

