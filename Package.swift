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
                           .product(name: "AdaptiveCards", package: "AdaptiveCards")]),
        .binaryTarget(
            name: "ContactCenterMessagingSDK",
            url: "https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases/download/v0.0.2/ContactCenterMessagingSDK.zip",
            checksum: "b30812cf887c967b37fa84027a82a1de0559ccfa3c1d942dc15357986f65e3c2"
        )
    ]
)
