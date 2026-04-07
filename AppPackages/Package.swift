// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppPackages",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
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
        .package(url: "https://github.com/miejoy/navigation-flow.git", branch: "main"),
        .package(url: "https://github.com/miejoy/alert-flow.git", branch: "main"),
        .package(url: "https://github.com/miejoy/network-ability.git", branch: "main"),
        .package(url: "https://github.com/miejoy/toast-flow.git", branch: "main"),
        .package(url: "https://github.com/miejoy/push-manager.git", branch: "main"),
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
                .product(name: "NetworkAbility", package: "network-ability"),
                .product(name: "ToastFlow", package: "toast-flow"),
                .product(name: "PushManager", package: "push-manager"),
            ]
        )
    ]
)
