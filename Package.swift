// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let repo = "https://github.com/vmanot/binary-Swallow/raw/1.0.9004/"
let modules = ["Swallow", "Runtime", "Diagnostics"]

let package = Package(
  name: "Swallow",

    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],

  products: modules.map {
      .library(name: $0, type: .static, targets: [$0, "Swallow_Binder"]
    ) },

    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.1.0"),
    ],

  targets: [
    .target(name: "Swallow_Binder"),
        .macro(
            name: "ExpansionsMacros",
            dependencies: [
                "Swallow",
                .product(name: "SwiftDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftOperators", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftParserDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                /*"SwiftSyntaxUtilities",*/
            ],
            path: "Sources/ExpansionsMacros"
        ),
        .macro(
            name: "MacroBuilderCompilerPlugin",
            dependencies: [
                /*"MacroBuilderCore",*/
                "Swallow"
            ],
            path: "Sources/MacroBuilderCompilerPlugin"
        ),
    .binaryTarget(
        name: "Swallow",
        url: repo + "Swallow.xcframework.zip",
        checksum: "17687734a8c0049258b002f1c0e2c5851efe1ef34d5dfcc0730dc845a17a7f5e"
    ),
    .binaryTarget(
        name: "Runtime",
        url: repo + "Runtime.xcframework.zip",
        checksum: "a41edf2a0ae4c30451da0102559b60a11a76ef3b82e5ddf2cf3aad714dcdea6b"
    ),
    .binaryTarget(
        name: "Diagnostics",
        url: repo + "Diagnostics.xcframework.zip",
        checksum: "5c87e98b8b057fc18ef95985f9fe7b932082e0edc95857c2b5adb5f51d16e421"
    ),
  ]
)
