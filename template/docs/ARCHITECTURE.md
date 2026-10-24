# Architecture: <Project name>

One page. Written on Day 0 from `docs/BRIEF.md`, before `docs/SPEC.md`.

## Choice and why
Default: **modular monolith**. One deployable app, one database, feature modules.
- Chosen:
- Why (link the brief answers that drove it):

## Context (C4 level 1)
Who uses the system and what it talks to.

```text
[User] --> [<Project name>] --> [Database]
                  |
                  +--> [Payments]
                  +--> [Email]
```

## Module map
Group the use cases by the business noun they mostly change. Each module owns its data.

| Module | Use cases | Owns (tables) | Public API (index) |
|---|---|---|---|
| orders | UC-1, UC-2 | orders, order_items | createOrder, getOrder |
| billing | UC-3 | invoices, payments | chargeOrder |

## Outside systems
| System | Used for | Wrapped in |
|---|---|---|
| <Payments> | Charging cards | `src/modules/billing/` adapter file |

## Non-functional numbers
- Users at launch / in a year:
- Peak requests per second:
- Reads or writes heavy:
- Sensitive data:
- OK downtime:
- Monthly hosting budget:

## Level-up triggers
Act only when one fires. Log the change in `docs/DECISIONS.md`.
1. Boundary violations keep happening: add an import check or lint rule.
2. One module's rules grow complex and change often: give that module a domain model.
3. A separate team owns a module, or it needs its own release or scaling: extract it as a service.
4. Security or compliance isolation is needed: extract that part.
5. The codebase is too big for one person or one agent session: tighten module APIs first, split later.
6. Events must cross process boundaries reliably: add an outbox.
