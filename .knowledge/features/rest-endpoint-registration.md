---
type: feature
title: REST Endpoint Registration
description: REST method/path helpers and handler registration for plugin HTTP extensions
resource: src/helpers.js
tags: [js-plugin-build-sdk, rest, endpoints, handlers]
timestamp: 2026-07-07T00:00:00Z
---

# REST Endpoint Registration

## Purpose

Register plugin REST endpoints (GET/POST/PUT/PATCH/DELETE) with JSON schema hints and named handlers. Engine routes HTTP traffic to plugin process via gRPC function dispatch.

## Flows

- **Define**: `GETEndpoint`, `POSTEndpoint`, etc. with path, description, optional schema.
- **Register**: `plugin.registerRESTAPI(endpoint, handlerFn)` or batch `registerRESTAPIs`.
- **Handler args**: `getPathParam`, `getQueryParam`, `getBodyParam`, `logRESTArgs`.
- **Schema**: `ObjectSchema`, `ArraySchema`, primitive schemas for validation hints.

## Main files

- `src/helpers.js` — endpoint + param helpers, JSON schema builders
- `src/main.js` — `registerRESTAPI`, `restHandlers` map
- `src/index.js` — exports

## Dependencies

- [plugin-init-serve-lifecycle](plugin-init-serve-lifecycle.md)
- [custom-functions-and-context](custom-functions-and-context.md) for handler context

## Invariants

- Handler name in endpoint must exist in `restHandlers` map.
- Paths must be unique per plugin — collisions fail at engine merge.
- Return JSON-serializable objects from handlers.

## Common bugs

- Body parser assumptions — use `getBodyParam` not raw `args.body` shape guesses.
- Missing path param name match → undefined in handler.
- REST handler throws plain Error — prefer coded errors (Go SDK) or structured response.

## Tests

- Example REST plugin route via engine HTTP proxy
- Manual `logRESTArgs` during development

## Related

- Go: [rest-endpoints-multipart](../go-plugin-build-sdk/.knowledge/features/rest-endpoints-multipart.md)
- [error-handling-graphql](error-handling-graphql.md) for shared error patterns
