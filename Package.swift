// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CleanUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CleanUI",
            targets: ["CleanUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/knoggl/SwiftPlus.git", .upToNextMajor(from: "1.2.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CleanUI",
            dependencies: ["SwiftPlus"]),
        .testTarget(
            name: "CleanUITests",
            dependencies: ["CleanUI", "SwiftPlus"]),
    ]
)
