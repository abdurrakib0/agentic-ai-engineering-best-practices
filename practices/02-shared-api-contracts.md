# 02. Shared API contracts

## Problem

Client and server define the same shapes twice. Over time they drift: a field gets renamed on one side, a type changes, and bugs show up only at runtime.

## Practice

- Write each module's contract once, as zod schemas in `src/contracts/<module>.ts`.
- **Both** client and server import from it. No hand-written duplicate types.
- Contracts are written **before** the endpoint is built, from the HANDOVER.md API table.
- A `check:contracts` CI gate fails when a route has no contract, or a contract is unused.

## Why

Agents working on client and server separately cannot see each other's choices. A shared file is the single source of truth they both read, and TypeScript catches mismatches at build time.

## Benefit

- No interface drift between client and server.
- Validation and types come from the same schema.
- Parallel agents can build client and server at the same time.

## Example

```ts
// src/contracts/tasks.ts
import { z } from "zod";

export const CreateTaskInput = z
  .object({
    title: z.string().min(1).max(200),
    assigneeId: z.string().uuid().optional(),
    dueDate: z.string().datetime().optional(),
  })
  .strict(); // allowlist: unknown keys are rejected

export const Task = z.object({
  id: z.string().uuid(),
  title: z.string(),
  assigneeId: z.string().uuid().nullable(),
  createdAt: z.string().datetime(),
});

export type CreateTaskInput = z.infer<typeof CreateTaskInput>;
export type Task = z.infer<typeof Task>;
```

```ts
// server
const input = CreateTaskInput.parse(await req.json());

// client
const body: CreateTaskInput = { title };
```

A simple `check:contracts` script: list every API route file, and fail if it does not import from `src/contracts/`.
