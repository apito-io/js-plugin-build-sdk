---
type: feature
title: Custom Functions and Context
description: Register engine-invokable functions and access request context in resolvers
resource: src/main.js
tags: [js-plugin-build-sdk, functions, context, engine]
timestamp: 2026-07-07T00:00:00Z
---

# Custom Functions and Context

## Purpose

Plugins expose named **functions** (health checks, cron hooks, internal engine calls) beyond GraphQL resolvers. Request **context** carries auth, project, and trace metadata into resolver/handler callbacks.

## Flows

- **Register function**: `plugin.registerFunction('my_job', async (context, args) => …)`.
- **Health**: built-in `health_check` registered in constructor.
- **Resolver context**: first arg to query/mutation/REST handlers — engine-populated metadata.
- **Invoke**: engine calls function by name over gRPC plugin protocol.

## Main files

- `src/main.js` — `registerFunction`, `functions` map, dispatch
- `src/helpers.js` — arg extractors using context + args objects

## Dependencies

- [plugin-init-serve-lifecycle](plugin-init-serve-lifecycle.md)
- Global: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md)

## Invariants

- Function names must be unique within plugin.
- Handlers should be idempotent where engine may retry.
- Do not store mutable global state — use context + engine storage APIs.

## Common bugs

- Assuming `context.user` always present — guard optional auth.
- Long-running function blocks gRPC thread — offload or return job id.
- Function registered after `serve()` — ignored.

## Tests

- `health_check` returns OK when plugin up
- Engine plugin manager function invoke test

## Related

- [graphql-registration-helpers](graphql-registration-helpers.md), [rest-endpoint-registration](rest-endpoint-registration.md)
- Global: [plugin-grpc-protocol](../../../../.knowledge/features/plugin-grpc-protocol.md)
