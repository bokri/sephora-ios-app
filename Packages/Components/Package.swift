// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Components",
            targets: ["Components"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/liamnichols/xcstrings-tool-plugin.git", from: Version("0.5.2")),
        .package(name: "Entities", path: "../Entities")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Components",
            dependencies: [
                .product(name: "Entities", package: "Entities"),
                .product(name: "XCStringsToolPlugin", package: "xcstrings-tool-plugin")
            ],
            resources: [
                .process("Resources"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .define("XCSTRINGS_TOOL_ACCESS_LEVEL_PUBLIC")
            ]
        ),
        .testTarget(
            name: "ComponentsTests",
            dependencies: [
                "Components",
            ],
            swiftSettings: [.enableUpcomingFeature("StrictConcurrency")]
        )
    ]
)
