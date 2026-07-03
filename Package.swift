// swift-tools-version:5.9
//
// Wortise SDK — Swift Package Manager manifest.
//
// On every release:
//   1. Run `./package.sh <version>` and `./upload.sh <version>` from the private
//      build repo. The `upload.sh` script prints the SPM url + checksum.
//   2. Update `version`, `binaryTargetUrl`, and `binaryTargetChecksum` below.
//   3. Commit and tag this repo with the same version (e.g. `1.8.0`).
//
// Mediation-adapter package URLs and library product names below mirror Google's
// official Swift Package Manager publications. Verify them against Google's
// current Swift Package distribution docs at release time:
// https://developers.google.com/admob/ios/mediation
//

import PackageDescription

private let version              = "1.8.0-beta.1"
private let binaryTargetUrl      = "https://cdn.resources.wortise.com/sdk/ios/wortise-ios-sdk-spm-\(version).zip"
private let binaryTargetChecksum = "6da0b2ee10cdd07ed1aeb0ce220f1e2f3e60374e8a58ee22c30142018af9a55b"

let package = Package(
    name: "WortiseSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "WortiseSDK",             targets: ["WortiseSDK"]),
        .library(name: "WortiseSDKFacebook",     targets: ["WortiseSDKFacebook"]),
        .library(name: "WortiseSDKFyber",        targets: ["WortiseSDKFyber"]),
        .library(name: "WortiseSDKInMobi",       targets: ["WortiseSDKInMobi"]),
        .library(name: "WortiseSDKIronSource",   targets: ["WortiseSDKIronSource"]),
        .library(name: "WortiseSDKPangle",       targets: ["WortiseSDKPangle"]),
        .library(name: "WortiseSDKUnity",        targets: ["WortiseSDKUnity"]),
        .library(name: "WortiseSDKVungle",       targets: ["WortiseSDKVungle"])
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",                          from: "12.4.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-meta.git",           from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-dtexchange.git",     from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-inmobi.git",         from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-ironsource.git",     from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-pangle.git",         from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-unity.git",          from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads-mediation-vungle.git",         from: "1.0.0")
    ],
    targets: [
        .binaryTarget(
            name:     "WortiseSDK",
            url:      binaryTargetUrl,
            checksum: binaryTargetChecksum
        ),
        .target(
            name: "WortiseSDKFacebook",
            dependencies: [
                "WortiseSDK",
                .product(name: "MetaAdapter", package: "swift-package-manager-google-mobile-ads-mediation-meta")
            ]
        ),
        .target(
            name: "WortiseSDKFyber",
            dependencies: [
                "WortiseSDK",
                .product(name: "DTExchangeAdapter", package: "swift-package-manager-google-mobile-ads-mediation-dtexchange")
            ]
        ),
        .target(
            name: "WortiseSDKInMobi",
            dependencies: [
                "WortiseSDK",
                .product(name: "InMobiAdapter", package: "swift-package-manager-google-mobile-ads-mediation-inmobi")
            ]
        ),
        .target(
            name: "WortiseSDKIronSource",
            dependencies: [
                "WortiseSDK",
                .product(name: "IronSourceAdapter", package: "swift-package-manager-google-mobile-ads-mediation-ironsource")
            ]
        ),
        .target(
            name: "WortiseSDKPangle",
            dependencies: [
                "WortiseSDK",
                .product(name: "PangleAdapter", package: "swift-package-manager-google-mobile-ads-mediation-pangle")
            ]
        ),
        .target(
            name: "WortiseSDKUnity",
            dependencies: [
                "WortiseSDK",
                .product(name: "UnityAdapter", package: "swift-package-manager-google-mobile-ads-mediation-unity")
            ]
        ),
        .target(
            name: "WortiseSDKVungle",
            dependencies: [
                "WortiseSDK",
                .product(name: "VungleAdapter", package: "swift-package-manager-google-mobile-ads-mediation-vungle")
            ]
        )
    ]
)
