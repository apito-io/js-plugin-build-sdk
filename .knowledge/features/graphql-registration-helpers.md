---
type: feature
title: GraphQL Registration Helpers
description: Field and argument builders plus query/mutation resolver registration on Plugin
resource: src/helpers.js
tags: [js-plugin-build-sdk, graphql, resolvers, registration]
timestamp: 2026-07-07T00:00:00Z
---

# GraphQL Registration Helpers

## Purpose

Fluent helpers to define GraphQL fields, args, and object types without hand-writing schema SDL. Registers resolvers on the `Plugin` maps consumed by the engine at handshake.

## Flows

- **Field builders**: `StringField`, `IntField`, `ListField`, `NonNullField`, `FieldWithArgs`.
- **Args**: `StringArg`, `ObjectArg`, `ListArg`, etc.
- **Types**: `NewObjectType`, `createObjectType`, scalar/list/non-null wrappers.
- **Register**: `plugin.registerQuery(name, field, resolverFn)` / `registerMutation`.
- **Batch**: `registerQueries(map, resolversMap)` for multiple ops.

## Main files

- `src/helpers.js` — field/arg/type builders
- `src/main.js` — `registerQuery`, `registerMutation`, resolver maps
- `src/index.js` — re-exports

## Dependencies

- [plugin-init-serve-lifecycle](plugin-init-serve-lifecycle.md)
- Engine plugin GraphQL extension protocol

## Invariants

- Resolver function names must match `field.resolve` string keys in registration.
- Object types referenced in fields must be registered before serve.
- Do not mutate registration maps after `serve()` starts.

## Common bugs

- Resolver async throw not converted — use [error-handling-graphql](error-handling-graphql.md) helpers.
- `ListField` / `NonNullField` nesting order wrong → invalid GraphQL type tree.
- Duplicate query name registration — last wins silently.

## Tests

- Example plugin registering sample query/mutation
- Engine integration: plugin appears in merged schema

## Related

- [error-handling-graphql](error-handling-graphql.md)
- Go: [graphql-type-system](../go-plugin-build-sdk/.knowledge/features/graphql-type-system.md)
