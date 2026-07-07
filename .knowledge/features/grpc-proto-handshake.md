---
type: feature
title: gRPC Proto Handshake
description: Proto loader setup and HashiCorp go-plugin gRPC handshake with Apito engine host
resource: src/main.js
tags: [js-plugin-build-sdk, grpc, proto, handshake]
timestamp: 2026-07-07T00:00:00Z
---

# gRPC Proto Handshake

## Purpose

Loads Apito plugin protobuf definitions and completes HashiCorp **go-plugin** handshake so the engine host can call `PluginService` over gRPC. Shared protocol: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md).

## Flows

- **Load proto**: `@grpc/proto-loader` reads engine plugin proto paths.
- **Create server**: gRPC `Server` with `PluginService` implementation.
- **Handshake**: engine spawns plugin subprocess, negotiates API version, connects client.
- **Dispatch**: host calls registered queries/mutations/REST/functions via RPC.

## Main files

- `src/main.js` — proto load, gRPC server bind, service impl
- Package dependency on engine proto artifacts / `apito-io/types` protos

## Dependencies

- Global: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md)
- `@grpc/grpc-js`, `@grpc/proto-loader`
- HashiCorp go-plugin protocol compatibility

## Invariants

- Plugin must speak same proto version as engine — upgrade SDK when engine bumps protos.
- API key validated at registration, not at proto load.
- Stdio logging per HashiCorp convention — avoid corrupting handshake stdout.

## Common bugs

- Proto include paths break when plugin packaged — use SDK-resolved absolute paths.
- gRPC port conflict when running multiple plugins locally.
- Logging to stdout before handshake completes — host parse failure.

## Tests

- Local engine + example plugin connect
- Compare with Go plugin `Serve()` handshake

## Related

- [plugin-init-serve-lifecycle](plugin-init-serve-lifecycle.md)
- Go: [plugin-init-serve](../go-plugin-build-sdk/.knowledge/features/plugin-init-serve.md)
- Global: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md)
