---
type: feature
title: Plugin Init Serve Lifecycle
description: Plugin class construction, init entrypoint, gRPC server start and health checks
resource: src/main.js
tags: [js-plugin-build-sdk, plugin, grpc, lifecycle]
timestamp: 2026-07-07T00:00:00Z
---

# Plugin Init Serve Lifecycle

## Purpose

Bootstraps a Node.js Apito engine plugin: register capabilities, start gRPC server, expose health check. Abstracts HashiCorp plugin boilerplate for plugin authors.

## Flows

- **Create**: `const plugin = init(name, version, apiKey)` or `new Plugin(...)`.
- **Register**: queries, mutations, REST, functions, health checks on plugin instance.
- **Serve**: `plugin.serve()` — loads proto, starts gRPC, handshake with engine host.
- **Shutdown**: process signals close server gracefully.
- **Health**: auto-registers `health_check` function on construct.

## Main files

- `src/main.js` — `Plugin` class, `init`, serve/stop
- `src/index.js` — public exports
- Engine proto definitions (loaded at runtime from package paths)

## Dependencies

- [grpc-proto-handshake](grpc-proto-handshake.md)
- `@grpc/grpc-js`, `@grpc/proto-loader`
- Global: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md)

## Invariants

- Plugin `apiKey` must match engine registration.
- `serve()` only after all registrations complete.
- One plugin process per HashiCorp plugin contract — no double serve.

## Common bugs

- Missing `#!/usr/bin/env node` in plugin entry when used as CLI binary.
- Serve called before resolvers registered → empty schema at host.
- Proto path wrong when plugin run from unexpected cwd.

## Tests

- `examples/` plugin smoke test against local engine
- Manual health_check invocation via engine plugin manager

## Related

- Go parity: `go-plugin-build-sdk` [plugin-init-serve](../go-plugin-build-sdk/.knowledge/features/plugin-init-serve.md)
- Global: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md)
