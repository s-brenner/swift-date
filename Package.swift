// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift-date",
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
