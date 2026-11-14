# Wortise SDK — Swift Package Manager distribution

This repository hosts the Swift Package Manager manifest for the Wortise iOS SDK.
The compiled SDK binary (`WortiseSDK.xcframework`) is distributed as a zip
artifact via the Wortise CDN and referenced from [`Package.swift`](Package.swift)
as a `binaryTarget`.

> The Wortise SDK is also available through CocoaPods. See the
> [integration guide](https://docs.wortise.com/ios-sdk/sdk-integration/).

## Requirements

- iOS 15.0 or later.

## Installation

In Xcode: **File → Add Package Dependencies…**, then enter:

```
https://github.com/wortise/wortise-ios-sdk-spm
```

Or in your own `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/wortise/wortise-ios-sdk-spm", from: "1.8.1")
]
```

## Products

| Product | What it includes |
|---|---|
| `WortiseSDK` | The SDK plus the Google Mobile Ads mediation adapters Wortise uses (BidMachine, DT Exchange, InMobi, Liftoff Monetize, Meta, Pangle, Unity Ads). Recommended. |
| `WortiseSDKCore` | The SDK only. Add Google's per-network adapter packages yourself if you want a subset. |

## Documentation

Full integration and API documentation is available at
[https://docs.wortise.com](https://docs.wortise.com).

## License

Copyright Wortise. All rights reserved. See [LICENSE](LICENSE).
