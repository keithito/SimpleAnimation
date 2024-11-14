// swift-tools-version:5.8
import PackageDescription

let package = Package(
  name: "SimpleAnimation",
  platforms: [
    .iOS(.v11),
    .tvOS(.v11),
    .watchOS(.v4)
  ],
  products: [
    .library(name: "SimpleAnimation", targets: ["SimpleAnimation"]),
  ],
  targets: [
    .target(name: "SimpleAnimation", path: "Source", resources: [.copy("PrivacyInfo.xcprivacy")]),
  ],
  swiftLanguageVersions: [
    .v5
  ]
)
