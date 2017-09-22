// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "RxJSON",
  products: [
    .library(name: "RxJSON", targets: ["RxJSON"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .branch("rxswift4.0-swift4.0")),
  ],
  targets: [
    .target(name: "RxJSON", dependencies: ["RxSwift"]),
    .testTarget(name: "RxJSONTests", dependencies: ["RxJSON", "RxBlocking"]),
  ]
)
