// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppPackages",
    platforms: [
        .macOS(.v12),
        .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppPackages",
            targets: ["AppPackages"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/miejoy/data-flow.git", branch: "main"),
        .package(url: "https://github.com/miejoy/view-flow.git", branch: "main"),
        .package(url: "https://github.com/miejoy/present-flow.git", branch: "main"),
        .package(url: "https://gogs.miejoy.com:4443/Swift/navigation-flow.git", branch: "master"),
        .package(url: "https://gogs.miejoy.com:4443/Swift/alert-flow.git", branch: "master"),
    ],
    targets: [
        .target(
            name: "AppPackages",
            dependencies: [
                .product(name: "DataFlow", package: "data-flow"),
                .product(name: "ViewFlow", package: "view-flow"),
                .product(name: "PresentFlow", package: "present-flow"),
                .product(name: "NavigationFlow", package: "navigation-flow"),
                .product(name: "AlertFlow", package: "alert-flow"),
            ]
        )
    ]
)
