// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GelatinDemo",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .executable(
            name: "GelatinDemo",
            targets: ["GelatinDemo"]
        )
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .executableTarget(
            name: "GelatinDemo",
            dependencies: [
                .product(name: "Gelatin", package: "Gelatin")
            ],
            path: "."
        )
    ]
) 