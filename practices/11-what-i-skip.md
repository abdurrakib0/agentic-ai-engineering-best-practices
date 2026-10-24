# 11. What I skip

## Problem

Some good ideas are too heavy for most projects. Adopting them early costs more than it saves.

## Practice

I skip a **full Clean Architecture or DDD rewrite** (separate Domain, Application, Infrastructure and API layers, bounded contexts, a context map, cross-module communication only through domain events).

I keep the lighter parts: module boundaries, one spec per module, shared contracts, a glossary and owned data per module. The default structure is a modular monolith, chosen on Day 0 ([practice 24](24-day0-discovery-and-architecture.md)).

I also skip heavy security process ([practice 25](25-security-baseline.md) covers the real risks):

- STRIDE or other threat-model documents
- Full OWASP ASVS checklists
- DAST scanners such as ZAP
- Pen tests before you have real users
- SBOMs, artifact signing and SLSA provenance
- WAF, SIEM or Vault setups
- Multiple or paid code scanners
- AI security review on every PR (only on risky ones)
- Runner hardening actions such as harden-runner

## Why

For small and medium apps, the extra layers add files, indirection and ceremony without a matching drop in bugs. Agents also have to read more code to make a small change.

## Benefit

- Less boilerplate, faster delivery.
- Most of the benefit (clear boundaries, small blast radius) at a fraction of the cost.

## When it would make sense

Act only when a named level-up trigger fires (the same list as [practice 24](24-day0-discovery-and-architecture.md)):

- Boundary violations keep happening: add an import check or lint rule.
- One module's rules grow complex and change often: give that module a domain model.
- A separate team owns a module, or it needs its own release or scaling: extract it as a service.
- Security or compliance isolation is needed: extract that part.
- The codebase is too big for one person or one agent session: tighten module APIs first, split later.
- Events must cross process boundaries reliably: add an outbox.

## Example

If you reach that point, migrate one module at a time behind its existing HANDOVER.md and contracts. Do not rewrite everything at once.
