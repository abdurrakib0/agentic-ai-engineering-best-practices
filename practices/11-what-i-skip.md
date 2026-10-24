# 11. What I skip

## Problem

Some good ideas are too heavy for most projects. Adopting them early costs more than it saves.

## Practice

I skip a **full Clean Architecture or DDD rewrite** (separate Domain, Application, Infrastructure and API layers, bounded contexts, a context map, cross-module communication only through domain events).

I keep the lighter parts: module boundaries, one spec per module, shared contracts, a glossary and owned data per module.

## Why

For small and medium apps, the extra layers add files, indirection and ceremony without a matching drop in bugs. Agents also have to read more code to make a small change.

## Benefit

- Less boilerplate, faster delivery.
- Most of the benefit (clear boundaries, small blast radius) at a fraction of the cost.

## When it would make sense

- Many teams or many agents working on clearly separate business areas.
- Complex business rules that change often.
- Modules that may become separate services.
- A codebase large enough that one agent cannot reason about a module without strict layers.

## Example

If you reach that point, migrate one module at a time behind its existing HANDOVER.md and contracts. Do not rewrite everything at once.
