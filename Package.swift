// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-date",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(name: "SBDate", targets: ["SBDate"]),
    ],
    dependencies: [
        .package(url: "https://github.com/s-brenner/swift-foundation", from: "0.0.0"),
    ],
    targets: [
        .target(
            name: "SBDate",
            dependencies: [
                .product(name: "SBFoundation", package: "swift-foundation"),
            ]
        ),
        .testTarget(name: "SBDateTests", dependencies: ["SBDate"]),
    ]
)
