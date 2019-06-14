// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "RxJSON",
  platforms: [
    .macOS(.v10_11), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)
  ],
  products: [
    .library(name: "RxJSON", targets: ["RxJSON"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "4.0.0-rc.0")),
  ],
  targets: [
    .target(name: "RxJSON", dependencies: ["RxSwift"]),
    .testTarget(name: "RxJSONTests", dependencies: ["RxJSON", "RxBlocking"]),
  ]
)
