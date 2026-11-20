// swift-tools-version:5.9
//
// Wortise SDK — Swift Package Manager manifest.
//
// Releases are automated: wortise-ios-sdk/scripts/publish.sh rewrites `version` and
// `binaryTargetChecksum` below (keep those line prefixes), commits and tags this repo.
//
// The WortiseSDK binary does NOT embed Google Mobile Ads — it references GMA at
// runtime, so the consumer links it. Both products go through the
// `WortiseGoogleMobileAds` target, which pins GMA to the 13.x line starting at the
// version the binary is built against (mirrors the podspec's `~> 13.x`). The
// default `WortiseSDK` product also bundles the GMA mediation adapters via
// `WortiseGoogleMediationAdapters` (mirroring the CocoaPods podspec). Apps that
// want only a subset of adapters should depend on `WortiseSDKCore` plus Google's
// per-adapter packages directly.
//
// Mediation-adapter packages are Google's official per-adapter SPM repos:
//   https://github.com/googleads/googleads-mobile-ios-mediation-<partner>
// Product names are "<Partner>AdapterTarget". Each adapter versions independently
// (tracking its partner SDK) but pins google-mobile-ads to the same 13.x line.
// Adapter tags encode the podspec's 4th component in the patch: pod 6.22.1.0 is
// tag 6.22.100, pod 8.4.0.8.0 is tag 8.4.00800. Each range below locks the partner
// SDK we tested and only lets Google's adapter revisions through, like the
// podspec's `~> x.y.z.0` pins.
// Verify against https://developers.google.com/admob/ios/mediation at release time.
//
// The `WortiseGoogleMediationAdapters` name is deliberate: Wortise's own mediation
// adapters will ship later as separate `WortiseAdapter<Network>` products, and the
// GMA bundles must not squat on that namespace.
//

import PackageDescription

private let version              = "1.8.2-beta.1"
private let binaryTargetUrl      = "https://cdn.resources.wortise.com/sdk/ios/wortise-ios-sdk-spm-\(version).zip"
private let binaryTargetChecksum = "2fb01a2629f05b6ae4f1844abf7a460522fc591cce21bd2701ac70cc50d895ce"

let package = Package(
    name: "WortiseSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Default product — mirrors the CocoaPods pod: the SDK plus every GMA adapter.
        .library(name: "WortiseSDK", targets: [
            "WortiseGoogleMobileAds",
            "WortiseGoogleMediationAdapters"
        ]),
        // SDK only, for apps that pick GMA adapters à la carte from Google's packages.
        .library(name: "WortiseSDKCore", targets: ["WortiseGoogleMobileAds"])
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",       "13.12.0" ..< "14.0.0"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-bidmachine.git",      "3.8.200" ..< "3.8.300"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-dtexchange.git",      "8.5.200" ..< "8.5.300"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-inmobi.git",          "11.5.000" ..< "11.5.100"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-liftoffmonetize.git", "7.7.800" ..< "7.7.900"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-meta.git",            "6.22.100" ..< "6.22.200"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-pangle.git",          "8.4.00800" ..< "8.4.00900"),
        .package(url: "https://github.com/googleads/googleads-mobile-ios-mediation-unity.git",           "4.21.000" ..< "4.21.100"),
    ],
    targets: [
        .binaryTarget(
            name:     "WortiseSDK",
            url:      binaryTargetUrl,
            checksum: binaryTargetChecksum
        ),
        .target(
            name: "WortiseGoogleMobileAds",
            dependencies: [
                "WortiseSDK",
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ]
        ),
        .target(
            name: "WortiseGoogleMediationAdapters",
            dependencies: [
                "WortiseGoogleMobileAds",
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
