// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "RxJSON",
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
