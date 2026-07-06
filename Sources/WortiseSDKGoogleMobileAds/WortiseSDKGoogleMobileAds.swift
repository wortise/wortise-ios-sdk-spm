//
//  WortiseSDKGoogleMobileAds.swift
//
//  The WortiseSDK binary no longer statically embeds the Google Mobile Ads SDK —
//  it references GMA symbols that are resolved at runtime from the app's single
//  copy. This target is bundled into the core `WortiseSDK` product so that
//  depending on WortiseSDK links Google Mobile Ads (matching the version the
//  binary was built against). Re-exporting it also lets `import WortiseSDK`
//  consumers reach the Google Mobile Ads API without importing it separately.
//

@_exported import GoogleMobileAds
