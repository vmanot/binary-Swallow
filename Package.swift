// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let repo = "http://github.com/vmanot/binary-Swallow/raw/1.0.9003/"
let modules = ["Swallow", "Runtime"]

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
        checksum: "8296bee5d110cb7fedf610ce889977396d6e38df1a2efdedecfa3b375e296f77"
    ),
    .binaryTarget(
        name: "Runtime",
        url: repo + "Runtime.xcframework.zip",
        checksum: "213c872f535e180235b2bf005196e9233d30341330cc1fcfcc9012edbb6eca5d"
    ),
  ]
)
