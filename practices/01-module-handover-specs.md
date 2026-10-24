# 01. Module handover specs

## Problem

An agent given a vague prompt fills gaps with guesses. It builds extra features, misses business rules and touches code it should not.

## Practice

- Every module gets one `HANDOVER.md` (for example `docs/<module>/HANDOVER.md`).
- It covers: purpose, in scope, out of scope, business rules, exact API list with the **required permission per endpoint**, data owned, events, tests and a **Drift** section.
- Agents read it **before** building and build **nothing outside it**.
- New scope means: update the spec first, get the owner's OK, then build.
- For big or risky specs, label claims: **[Fact]**, **[Assumption]**, **[Inference]**, **[Recommendation]**. Only facts and owner-approved items are buildable. See [practice 13](13-requirements-and-decisions.md). For small specs, labels are optional: just mark open questions as **[Assumption]**.
- When code and spec differ, log it in Drift and fix one of them. Never leave silent drift.
- **Research, plan, implement in fresh sessions.** For a big module: one session researches the code and writes short notes, one writes the plan or HANDOVER.md, and a fresh session builds from it. Review the research and the plan hardest: one wrong line there becomes many wrong lines of code.

## Why

The spec is the agent's context. A short, exact spec fits in the context window, so the agent does not need to hold the whole system in its head. A hard boundary keeps each change small.

## Benefit

- Agents build the right thing the first time.
- Blast radius stays inside one module.
- A new agent or person can understand a module from one file.
- Permissions are designed up front, not bolted on.

## Example

Full template: [snippets/HANDOVER.md](../snippets/HANDOVER.md).

```markdown
## 4. API
| Method | Path        | Purpose     | Required permission |
|--------|-------------|-------------|---------------------|
| GET    | /api/tasks  | List tasks  | tasks:read          |
| POST   | /api/tasks  | Create task | tasks:create        |

## 8. Drift
| Date       | What drifted                     | Decision          |
|------------|----------------------------------|-------------------|
| 2026-01-10 | Added `dueDate` filter not in spec | Spec updated, owner OK |
```

## Sources

- HumanLayer, Advanced context engineering for coding agents (research, plan, implement with intentional compaction): https://www.humanlayer.com/blog/advanced-context-engineering
