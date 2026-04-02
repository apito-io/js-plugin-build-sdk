# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2026-04-02

### Changed

- **BREAKING**: npm package renamed from `@apito-io/js-apito-plugin-sdk` to `@apito-io/js-plugin-build-sdk`
- Repository URL: `https://github.com/apito-io/js-plugin-build-sdk`
- Dependencies: `@grpc/grpc-js` ^1.14.3, `@grpc/proto-loader` ^0.8.0; `typescript` ~5.9.3
- GitHub Actions: publish workflow aligned with admin SDK (Node 22 publish, `action-gh-release@v2`, npm cache)
- README and examples use `require("@apito-io/js-plugin-build-sdk")` / `require(".../helpers")`

### Added

- [`.github/dependabot.yml`](.github/dependabot.yml) for weekly npm updates
