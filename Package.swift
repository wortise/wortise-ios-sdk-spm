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
// runtime, so the consumer links it. The default `WortiseSDK` product bundles the
// GMA mediation adapters via `WortiseGoogleMediationAdapters` (mirroring the
// CocoaPods podspec); the adapters pull in Google Mobile Ads and their partner
// SDKs transitively, so no separate GMA target is needed. Apps that want only a
// subset of adapters should depend on `WortiseSDKCore` plus Google's per-adapter
// packages directly.
//
// Mediation-adapter packages are Google's official per-adapter SPM repos:
//   https://github.com/googleads/googleads-mobile-ios-mediation-<partner>
// Product names are "<Partner>AdapterTarget". Each adapter versions independently
// (tracking its partner SDK) but pins google-mobile-ads to the same 13.x line.
// Verify against https://developers.google.com/admob/ios/mediation at release time.
//
// The `WortiseGoogleMediationAdapters` name is deliberate: Wortise's own mediation
// adapters will ship later as separate `WortiseAdapter<Network>` products, and the
// GMA bundles must not squat on that namespace.
//

import PackageDescription

private let version              = "1.8.0-beta.8"
private let binaryTargetUrl      = "https://cdn.resources.wortise.com/sdk/ios/wortise-ios-sdk-spm-\(version).zip"
private let binaryTargetChecksum = "28da29a7c5d396f9da46714dbefebc202c3a340cfa98cc3adcd41690a5e99cf5"

let package = Package(
    name: "WortiseSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Default product — mirrors the CocoaPods pod: the SDK plus every GMA adapter.
        .library(name: "WortiseSDK", targets: [
            "WortiseSDK",
            "WortiseGoogleMediationAdapters"
        ]),
        // SDK only, for apps that pick GMA adapters à la carte from Google's packages.
        .library(name: "WortiseSDKCore", targets: ["WortiseSDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-bidmachine.git",      from: "3.7.100"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-dtexchange.git",      from: "8.4.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-inmobi.git",          from: "11.3.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-liftoffmonetize.git", from: "7.7.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-meta.git",            from: "6.21.0"),
        // Pin Pangle to the 8.1.x line: the current 8.2.x adapter pins a ByteDance
        // AdsGlobalPackage pre-release (8.2.0-beta.3) that does not exist, breaking
        // resolution. 8.1.00600 pins the published 8.1.0-release.6 and GMA 13.3+.
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-pangle.git",          "8.1.0" ..< "8.2.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-unity.git",           from: "4.19.0"),
    ],
    targets: [
        .binaryTarget(
            name:     "WortiseSDK",
            url:      binaryTargetUrl,
            checksum: binaryTargetChecksum
        ),
        .target(
            name: "WortiseGoogleMediationAdapters",
            dependencies: [
                "WortiseSDK",
                .product(name: "BidMachineAdapterTarget",      package: "googleads-mobile-ios-mediation-bidmachine"),
                .product(name: "DTExchangeAdapterTarget",      package: "googleads-mobile-ios-mediation-dtexchange"),
                .product(name: "InMobiAdapterTarget",          package: "googleads-mobile-ios-mediation-inmobi"),
                .product(name: "LiftoffMonetizeAdapterTarget", package: "googleads-mobile-ios-mediation-liftoffmonetize"),
                .product(name: "MetaAdapterTarget",            package: "googleads-mobile-ios-mediation-meta"),
                .product(name: "PangleAdapterTarget",          package: "googleads-mobile-ios-mediation-pangle"),
                .product(name: "UnityAdapterTarget",           package: "googleads-mobile-ios-mediation-unity"),
            ]
        )
    ]
)
