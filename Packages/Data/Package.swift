// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LocationService",
            targets: ["LocationService"]),
        .library(
            name: "Models",
            targets: ["Models"]
        ),
        .library(
            name: "Networks",
            targets: ["Networks"]),
        .library(
            name: "Repositories",
            targets: ["Repositories"]),
        .library(
            name: "AppDefault",
            targets: ["AppDefault"]),
        .library(
            name: "EnvironmentManager",
            targets: ["EnvironmentManager"])
    ],
    dependencies: [
     .package(path: "../../Domain"),
     .package(path: "../../Utils")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LocationService",
            dependencies: [
              .product(name: "Domain", package: "Domain"),
              .product(name: "Utils", package: "Utils")
            ]),
        .target(
            name: "Models",
            dependencies: [
                "LocationService",
                .product(name: "Domain", package: "Domain"),
                .product(name: "Utils", package: "Utils")
            ]
        ),
        .target(
            name: "Networks",
            dependencies: [
                "Models",
                "AppDefault",
                "EnvironmentManager",
                .product(name: "Domain", package: "Domain"),
                .product(name: "Utils", package: "Utils")
            ]
        ),
        .target(
            name: "Repositories",
            dependencies: [
                "Models",
                "Networks",
                .product(name: "Domain", package: "Domain"),
                .product(name: "Utils", package: "Utils")
            ]
        ),
        .target(
            name: "AppDefault",
            dependencies: []
        ),
        .target(
            name: "EnvironmentManager",
            dependencies: ["AppDefault"]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Models",
                          "Repositories",
                           "LocationService",
                           "Networks",
                           .product(name: "Domain", package: "Domain"),
                           .product(name: "Utils", package: "Utils")
                          ]
        )
    ]
)
