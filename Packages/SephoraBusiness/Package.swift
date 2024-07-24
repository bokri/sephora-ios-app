// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SephoraBusiness",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SephoraBusiness",
            targets: ["SephoraBusiness"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: Version("9.1.0")),
        .package(name: "Entities", path: "../Entities")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SephoraBusiness",
            dependencies: [
                .product(name: "Entities", package: "Entities"),
            ],
            swiftSettings: [.enableUpcomingFeature("StrictConcurrency")]
        ),
        .testTarget(
            name: "SephoraBusinessTests",
            dependencies: [
                "SephoraBusiness",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [.enableUpcomingFeature("StrictConcurrency")]
        )
    ]
)
