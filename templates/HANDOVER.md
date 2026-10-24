# HANDOVER: <module name>

> Agents: read this file before building. Build nothing outside it.
> New scope? Update this spec first and get the owner's OK.

**Owner:** <name>
**Status:** draft | approved | building | done
**Last updated:** YYYY-MM-DD
**Requirements locked:** YYYY-MM-DD (see DECISIONS.md)

> Label every claim that is not obvious:
> **[Fact]** verified, **[Assumption]** believed but unverified,
> **[Inference]** derived from facts, **[Recommendation]** a proposal for the owner.
> Agents treat only [Fact] and owner-approved items as buildable.

## 1. Purpose

One or two sentences. What problem does this module solve, and for whom?

## 2. Scope

**In scope**
- ...

**Out of scope**
- ...

## 3. Business rules

1. [Fact] ...
2. [Assumption] ... (confirm with owner)

## 4. API

| Method | Path | Purpose | Required permission | Contract |
|--------|------|---------|---------------------|----------|
| GET | /api/<module> | List items | `<module>:read` | `src/contracts/<module>.ts#ListResponse` |
| POST | /api/<module> | Create item | `<module>:create` | `src/contracts/<module>.ts#CreateInput` |

## 5. Data owned

Tables or collections this module owns. Other modules never write to them directly.

| Entity | Key fields | Notes |
|--------|-----------|-------|
| ... | ... | ... |

## 6. Events

**Emits**
- `<module>.created` with payload `{ id, ... }`

**Listens to**
- ...

## 7. Tests

- Happy path: ...
- Validation: ...
- Authz (negative): a user without `<module>:create` gets 403.
- Edge cases: ...

## 8. Drift

Anything built that differs from this spec. Log it here, then fix the code or the spec.

| Date | What drifted | Decision |
|------|--------------|----------|
| | | |
