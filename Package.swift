// swift-tools-version:3.1

import PackageDescription

let package = Package(
  name: "RxJSON",
  dependencies: [
    .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3),
  ]
)
