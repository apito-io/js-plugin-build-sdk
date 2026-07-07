---
type: feature
title: Error Handling GraphQL
description: GraphQLError constructors and resolver throw helpers for plugin GraphQL extensions
resource: src/helpers.js
tags: [js-plugin-build-sdk, graphql, errors, validation]
timestamp: 2026-07-07T00:00:00Z
---

# Error Handling GraphQL

## Purpose

Standard GraphQL error shapes for plugin resolvers: validation, auth, not-found, and internal errors with extensions. Keeps engine error formatting consistent across JS plugins.

## Flows

- **Construct**: `createGraphQLError`, `createValidationError`, `createNotFoundError`, etc.
- **Throw helpers**: `throwValidationError`, `throwAuthenticationError`, `throwNotFoundError`.
- **Validate**: `validateRequired`, `validateField` before resolver logic.
- **Handle batch**: `handleGraphQLErrors` for multiple field errors.
- **Detect**: `isGraphQLError` type guard.

## Main files

- `src/helpers.js` — error classes and throw utilities
- `src/index.js` — exports all error helpers

## Dependencies

- [graphql-registration-helpers](graphql-registration-helpers.md) resolvers
- Engine GraphQL error extension conventions

## Invariants

- Use throw helpers — not raw `throw new Error()` in GraphQL resolvers.
- Validation errors should include field path in extensions when available.
- Do not leak stack traces in production `extensions`.

## Common bugs

- Plain Error swallowed by engine as generic 500 — use `GraphQLError` subclasses.
- `createGraphQLErrorWithCode` code not in engine allowlist — ignored by clients.
- Missing `await` in resolver — rejection not mapped to GraphQL error.

## Tests

- Resolver unit tests asserting thrown error extensions
- Engine GraphQL response includes `errors[].extensions.code`

## Related

- Go: [coded-and-graphql-errors](../go-plugin-build-sdk/.knowledge/features/coded-and-graphql-errors.md)
- [graphql-registration-helpers](graphql-registration-helpers.md)
