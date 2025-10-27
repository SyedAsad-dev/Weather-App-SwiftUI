// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Router",
            targets: ["Router"]),
    ],
    dependencies: [
     .package(path: "../../Favorite"),
     .package(path: "../../CityMap"),
     .package(path: "../../Forcast"),
     .package(path: "../../Utils"),
     .package(path: "../../Domain"),
     .package(path: "../../Data"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Router",
            dependencies: [
              .product(name: "Favorite", package: "Favorite"),
              .product(name: "CityMap", package: "CityMap"),
              .product(name: "Forcast", package: "Forcast"),
              .product(name: "Utils", package: "Utils"),
              .product(name: "Domain", package: "Domain"),
              .product(name: "Repositories", package: "Data"),
              .product(name: "Networks", package: "Data"),
              .product(name: "Models", package: "Data"),
              .product(name: "LocationService", package: "Data"),
            ])
    ]
)
