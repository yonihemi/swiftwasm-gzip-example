// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "SwiftwasmGzipExample",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "SwiftwasmGzipExample", targets: ["SwiftwasmGzipExample"])
    ],
    dependencies: [
        // TODO: Back to proper versions once TextEditor is released
        .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", .branch("main")),
        
        .package(name: "Gzip", url: "https://github.com/yonihemi/GzipSwift", .branch("swiftwasm")),
    ],
    targets: [
        .target(
            name: "SwiftwasmGzipExample",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak"),
                .product(name: "Gzip", package: "Gzip"),                
            ]),
        .testTarget(
            name: "SwiftwasmGzipExampleTests",
            dependencies: ["SwiftwasmGzipExample"]),
    ]
)