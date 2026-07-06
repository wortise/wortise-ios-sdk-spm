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
// The WortiseSDK binary does NOT embed Google Mobile Ads — it references GMA at
// runtime, so the consumer links it. The core `WortiseSDK` product bundles every
// mediation adapter (mirroring the CocoaPods podspec); the adapters pull in Google
// Mobile Ads transitively, so no separate GMA target is needed. Apps that want a
// subset can depend on the individual `WortiseSDK<Network>` products instead.
//
// Mediation-adapter packages are Google's official per-adapter SPM repos:
//   https://github.com/googleads/googleads-mobile-ios-mediation-<partner>
// Product names are "<Partner>AdapterTarget". Each adapter versions independently
// (tracking its partner SDK) but pins google-mobile-ads to the same 13.x line.
// Verify against https://developers.google.com/admob/ios/mediation at release time.
//

import PackageDescription

private let version              = "1.8.0-beta.5"
private let binaryTargetUrl      = "https://cdn.resources.wortise.com/sdk/ios/wortise-ios-sdk-spm-\(version).zip"
private let binaryTargetChecksum = "131dda7b2ccc7f519ea6e3005da2aa0d4544c8d0299115668b2084813c4feb51"

let package = Package(
    name: "WortiseSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Default product — mirrors the CocoaPods pod: the SDK plus every adapter.
        .library(name: "WortiseSDK", targets: [
            "WortiseSDK",
            "WortiseSDKFacebook",
            "WortiseSDKFyber",
            "WortiseSDKInMobi",
            "WortiseSDKIronSource",
            "WortiseSDKPangle",
            "WortiseSDKUnity",
            "WortiseSDKVungle"
        ]),
        // Granular products for the rare app that wants only a subset of adapters.
        .library(name: "WortiseSDKFacebook",     targets: ["WortiseSDKFacebook"]),
        .library(name: "WortiseSDKFyber",        targets: ["WortiseSDKFyber"]),
        .library(name: "WortiseSDKInMobi",       targets: ["WortiseSDKInMobi"]),
        .library(name: "WortiseSDKIronSource",   targets: ["WortiseSDKIronSource"]),
        .library(name: "WortiseSDKPangle",       targets: ["WortiseSDKPangle"]),
        .library(name: "WortiseSDKUnity",        targets: ["WortiseSDKUnity"]),
        .library(name: "WortiseSDKVungle",       targets: ["WortiseSDKVungle"])
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-meta.git",            from: "6.21.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-dtexchange.git",      from: "8.4.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-inmobi.git",          from: "11.3.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-ironsource.git",      from: "9.4.0"),
        // Pin Pangle to the 8.1.x line: the current 8.2.x adapter pins a ByteDance
        // AdsGlobalPackage pre-release (8.2.0-beta.3) that does not exist, breaking
        // resolution. 8.1.00600 pins the published 8.1.0-release.6 and GMA 13.3+.
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-pangle.git",          "8.1.0" ..< "8.2.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-unity.git",           from: "4.19.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-liftoffmonetize.git", from: "7.7.0")
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
                .product(name: "MetaAdapterTarget", package: "googleads-mobile-ios-mediation-meta")
            ]
        ),
        .target(
            name: "WortiseSDKFyber",
            dependencies: [
                "WortiseSDK",
                .product(name: "DTExchangeAdapterTarget", package: "googleads-mobile-ios-mediation-dtexchange")
            ]
        ),
        .target(
            name: "WortiseSDKInMobi",
            dependencies: [
                "WortiseSDK",
                .product(name: "InMobiAdapterTarget", package: "googleads-mobile-ios-mediation-inmobi")
            ]
        ),
        .target(
            name: "WortiseSDKIronSource",
            dependencies: [
                "WortiseSDK",
                .product(name: "IronSourceAdapterTarget", package: "googleads-mobile-ios-mediation-ironsource")
            ]
        ),
        .target(
            name: "WortiseSDKPangle",
            dependencies: [
                "WortiseSDK",
                .product(name: "PangleAdapterTarget", package: "googleads-mobile-ios-mediation-pangle")
            ]
        ),
        .target(
            name: "WortiseSDKUnity",
            dependencies: [
                "WortiseSDK",
                .product(name: "UnityAdapterTarget", package: "googleads-mobile-ios-mediation-unity")
            ]
        ),
        .target(
            name: "WortiseSDKVungle",
            dependencies: [
                "WortiseSDK",
                .product(name: "LiftoffMonetizeAdapterTarget", package: "googleads-mobile-ios-mediation-liftoffmonetize")
            ]
        )
    ]
)
