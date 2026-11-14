# Wortise iOS SDK - SPM distribution

`Package.swift` points at the binary on the CDN (`version` + `binaryTargetChecksum`). It is updated, committed and tagged by `wortise-ios-sdk/scripts/publish.sh`; do not edit by hand except for dependency changes (keep the `private let version` and `private let binaryTargetChecksum` line prefixes).

The `wortise-sdk` agent plugin (repo `wortise/wortise-sdk-agent`) holds the full context: how this repo relates to the other SDKs and plugins, versioning, branches, and the release procedure (`wortise-release` skill). Read it before releasing or making cross-platform changes.

- One annotated tag per version; publishers resolve it. Never move or delete a tag without the maintainer's explicit approval.
- Adapter packages here must match the `s.dependency` list in `wortise-ios-sdk/WortiseSDK.podspec`.
