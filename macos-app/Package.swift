// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Periodensystem",
    defaultLocalization: "de",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "Periodensystem", targets: ["Periodensystem"])
    ],
    targets: [
        .executableTarget(
            name: "Periodensystem",
            path: "Sources/Periodensystem"
        )
    ]
)
