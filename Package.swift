// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "ObjectAssociationHelper",
  platforms: [
    .iOS(.v13), .macOS(.v10_13), .tvOS(.v13), .watchOS(.v6)
  ],
  products: [
    .library(
      name: "ObjectAssociationHelper",
      targets: ["ObjectAssociationHelper"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ObjectAssociationHelper",
      dependencies: []
    ),
    .testTarget(
      name: "ObjectAssociationHelperTests",
      dependencies: ["ObjectAssociationHelper"]
    ),
  ]
)
