// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorite",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Favorite",
            targets: ["Favorite"]),
    ],
    dependencies: [
     .package(path: "../../Utils"),
     .package(path: "../../Domain")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Favorite",
            dependencies: [
              .product(name: "Utils", package: "Utils"),
              .product(name: "Domain", package: "Domain")
            ]),
        .testTarget(
            name: "FavoriteTests",
            dependencies: ["Favorite",
                           .product(name: "Utils", package: "Utils"),
                           .product(name: "Domain", package: "Domain")]
        ),
    ]
)
