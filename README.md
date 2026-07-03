# Wortise SDK — Swift Package Manager distribution

This repository hosts the Swift Package Manager manifest for the Wortise iOS SDK.
The compiled SDK binary (`WortiseSDK.xcframework`) is distributed as an
`xcframework.zip` artifact via the Wortise CDN and referenced from
[`Package.swift`](Package.swift) as a `binaryTarget`.

> The Wortise SDK is also available through CocoaPods. See
> [WortiseSDK on CocoaPods](https://cocoapods.org/pods/WortiseSDK) if you prefer
> that integration method.

## Requirements

- iOS 13.0 or later.
- Xcode 15 or later.

## Installation

Add the package to your project. In Xcode: **File → Add Packages…**, then enter:

```
https://github.com/wortise/wortise-ios-sdk-spm
```

Or in your own `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/wortise/wortise-ios-sdk-spm",
        from: "1.8.0"
    )
]
```

## Products

The package exposes one core product plus one optional product per supported
mediation adapter. Add only the products your app actually monetizes through —
each adapter pulls in the Google Mobile Ads mediation package transitively, so
unused adapters won't bloat your binary.

| Product | What it includes |
|---|---|
| `WortiseSDK` | Core SDK only. |
| `WortiseSDKFacebook` | Core SDK + Meta (Audience Network) adapter. |
| `WortiseSDKFyber` | Core SDK + DT Exchange (Fyber) adapter. |
| `WortiseSDKInMobi` | Core SDK + InMobi adapter. |
| `WortiseSDKIronSource` | Core SDK + ironSource adapter. |
| `WortiseSDKPangle` | Core SDK + Pangle adapter. |
| `WortiseSDKUnity` | Core SDK + Unity Ads adapter. |
| `WortiseSDKVungle` | Core SDK + Vungle (Liftoff Monetize) adapter. |

Example — app monetizing with Meta and Unity only:

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(name: "WortiseSDKFacebook", package: "wortise-ios-sdk-spm"),
        .product(name: "WortiseSDKUnity",    package: "wortise-ios-sdk-spm")
    ]
)
```

## Documentation

Full integration and API documentation is available at
[https://developers.wortise.com](https://developers.wortise.com).

## License

Copyright Wortise. All rights reserved. See [LICENSE](LICENSE).
