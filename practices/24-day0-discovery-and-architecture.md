# 24. Day 0 discovery and architecture

## Problem

Most expensive rework comes from two Day 0 mistakes: a vague brief, and a structure picked too early (often microservices or heavy layers). Agents make it worse. Given no structure, each agent invents its own. Given a fuzzy goal, they build features nobody asked for.

## Practice

Before any code, spend one short session on discovery. The agent asks, the owner answers, and the answers become a few short files.

### The flow

1. **BRIEF** (`docs/BRIEF.md`, one page): problem, user and job, success number, appetite (time budget), out of scope, future direction (likely vs dream). No appetite, no build.
2. **Use cases**: 3 to 7 lines, "As a <user> I can <do> so that <outcome>", in the order a user meets them.
3. **Module map** (`docs/ARCHITECTURE.md`): group use cases by the business noun they mostly change (orders, billing, accounts). Each group is a module that owns its data. New terms go in the [glossary](05-glossary.md).
4. **Architecture choice** (`docs/ARCHITECTURE.md`): use the decision table below. The default is a modular monolith. Write down the level-up triggers that would change it.
5. **DECISIONS**: one short entry per **one-way door** only (database, auth, tenancy, hosting, major vendor, public API shape). Two-way doors are just decided, no entry. See [practice 13](13-requirements-and-decisions.md).
6. **SPEC**: acceptance criteria from the use cases plus the rough numbers (users, load, data sensitivity). Then run the [grill pass](04-grill-pass.md).

### The 8 must-ask questions

1. Who is the main user, and what job are they hiring this product to do?
2. What are the top 3 to 5 things a user must be able to do in v1?
3. How much time are we willing to spend on v1: 1 to 2 weeks, 6 weeks, or more?
4. Where could this be in 1 to 2 years? Which parts are likely and which are dreams? (Only likely ones earn a design option now.)
5. How many users at launch and in a year? Peak requests per second? Mostly reads or writes?
6. What sensitive data do we hold (money, personal data, minors), and what laws or policies apply?
7. Which outside systems must we connect to (payments, SSO, SMS, email, an existing database)?
8. Who builds and maintains this (people and agents), and which stack do they know best?

The agent also answers one question itself, every time: **which choices here are one-way doors?** Each one gets a DECISIONS entry.

<details>
<summary><strong>Optional, for big projects: 17 more questions</strong></summary>

Product and users
- Walk me through the last time this problem happened. What did they do instead?
- How will we know it worked in 3 months? Pick one number.

Scope and appetite
- What is explicitly out of v1?
- Is this a throwaway test or something we will run for years?

Future direction
- Will other apps, partners, or a mobile app use this later?
- Will we need many organizations or tenants later? (Hard to retrofit, so decide now.)

Non-functional
- What must feel instant, and what can run in the background?
- What happens if it is down for one hour?
- What is the monthly hosting budget?

Integrations and data
- Who owns each main kind of data? Do we migrate data from an old system?
- Do we need real time updates, file uploads, search, or reports?

Team and constraints
- Any fixed hosting, vendor, or deadline constraints?
- Who approves decisions and production releases?

Risks and reversibility
- What is the riskiest assumption, and how can we test it cheaply first?
- Which choices are one-way doors here (database, auth, tenancy, vendor lock-in, public API shape)?
- What would make us regret this design in a year?
- Who could be harmed if this goes wrong (abuse, fraud, data leak)?

</details>

### Decision table

| Signal | Choose |
|--------|--------|
| New product, 1 to 10 builders, domain still unclear | **Modular monolith (default)** |
| Throwaway prototype, testing an idea in 1 to 2 weeks | Plain single app, minimal structure; plan to throw it away |
| Mostly CRUD screens and forms | Vertical slices with plain functions and SQL; no domain layer |
| One module has complex rules that change often (pricing, billing, scheduling) | Richer domain model inside that module only |
| A few spiky or scheduled jobs (webhooks, cron, image resize) | Serverless functions or a job queue next to the monolith |
| Very small app, low steady traffic, team wants zero ops | Serverless or a managed platform for the whole thing |
| One part needs a different runtime or heavy scale (video, ML inference) | Monolith plus one separate worker service |
| A separate team owns an area and needs its own release cadence | Extract that one module into a service |
| A part needs hard security or compliance isolation | Extract that part only |
| Many teams, mature CI, monitoring and on-call already in place | Microservices can pay off |

### The default: modular monolith

One deployable app, one database, feature modules:

```text
src/
  modules/
    orders/
      index.ts     # the only file other modules may import
      routes.ts
      service.ts   # plain functions, business rules live here
      db.ts        # queries for tables this module owns
      tests/
    billing/
      ...
  shared/          # config, logging, errors only
```

- Other modules import only a module's `index`.
- Each module owns its tables (own schema or table prefix). No cross-module joins or foreign keys into another module's tables. Call its public API instead.
- `src/shared/` stays small: config, logging, errors.

### Level-up triggers

Write these in ARCHITECTURE.md. Act only when one fires.

1. Boundary violations keep happening: add an import check or lint rule.
2. One module's rules grow complex and change often: give that module a domain model and its own glossary section.
3. A separate team owns a module, or it needs its own release or scaling: extract it as a service.
4. Security or compliance isolation is needed: extract that part.
5. The codebase is too big for one person or one agent session to understand: tighten module APIs first, split later.
6. Events must cross process boundaries reliably: add an outbox, not before.

### DDD-lite: keep and skip

Keep:
- The [glossary](05-glossary.md) as the shared language, created when the first term is confusing.
- Modules as bounded contexts: one business area, its own data, a public API.
- The same words in code, SPEC, UI and glossary.

Skip until a trigger fires (see [practice 11](11-what-i-skip.md)): layers per module (domain, application, infrastructure), aggregates, value-object ceremony, a domain events bus, context maps, CQRS, event sourcing.

### Design patterns

Add a pattern only when the same problem shows up twice in real code. Deletion test: if removing a layer makes the code simpler and nothing breaks, it was not needed.

Worth knowing:
- **Module public API (facade):** the `index` file of each module. Always.
- **Adapter:** wrap each outside service (payments, SMS, email) in one small file.
- **Strategy:** only when there are 2 or more real variants (payment providers, pricing rules).
- **Transaction script:** one function per use case. The default inside a module.
- **State machine:** for things with many statuses (order, application, ticket).
- **Outbox and idempotency keys:** only for payments, webhooks or events across processes.

Skip by default: inheritance trees, generic repositories over an ORM, a mediator on every call, factories for one type, dependency injection containers in small apps.

## Why

- Questions are cheap on Day 0 and expensive after launch. The few choices that are hard to undo (database, auth, tenancy) get real thought; everything else is decided fast.
- A modular monolith gives clear boundaries without network calls, extra deploys or cross-repo context the agent cannot see.
- Agents work best on simple, local code. One feature folder means one change touches one place, and parallel agents can own separate modules.

## Benefit

- The big, expensive mistakes are caught before any code.
- Agents follow one written structure instead of inventing their own.
- Less code and fewer moving parts to run and review.
- A clear, written path for when and how to grow the architecture.

## Example

`docs/ARCHITECTURE.md` (one page):

```markdown
## Choice
Modular monolith on Postgres. 3 builders, domain still unclear, no part needs separate scaling.

## Module map
| Module | Owns data | Public API | Use cases |
|--------|-----------|------------|-----------|
| accounts | users, sessions | getUser, requireSession | UC1 |
| courses | courses, lessons | listCourses, getLesson | UC2, UC3 |
| billing | payments, invoices | startCheckout, isPaid | UC4 |

## Level-up triggers
- Video processing needs its own scaling: move it to one worker service.
```

## Sources

- Shape Up, set the appetite ("Appetites start with a number and end with a design."): https://basecamp.com/shapeup/1.2-chapter-03
- Amazon 2015 shareholder letter, one-way vs two-way doors: https://s2.q4cdn.com/299287126/files/doc_financials/annual/2015-Letter-to-Shareholders.PDF
- Palantir, Forward Deployed Engineer role (own the outcome from the first customer conversation): https://jobs.lever.co/palantir/5168e8fd-fec1-4fea-b7a1-81bdaea65850
- Microsoft, architect role: design from business requirements: https://learn.microsoft.com/en-us/azure/well-architected/architect-role/design-business-requirements
- Christensen, Jobs to be done: https://hbr.org/2016/09/know-your-customers-jobs-to-be-done
- Jeff Patton, user story mapping: https://jpattonassociates.com/story-mapping/
- System design primer (use cases, constraints, assumptions first): https://github.com/donnemartin/system-design-primer
- Martin Fowler, MonolithFirst ("Almost all the successful microservice stories have started with a monolith that got too big and was broken up"): https://martinfowler.com/bliki/MonolithFirst.html
- Martin Fowler, Sacrificial architecture: https://martinfowler.com/bliki/SacrificialArchitecture.html
- Shopify, deconstructing the monolith: https://shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity
- Kamil Grzybek, modular monolith primer: https://www.kamilgrzybek.com/blog/posts/modular-monolith-primer
- Jimmy Bogard, vertical slice architecture: https://www.jimmybogard.com/vertical-slice-architecture/
- Martin Fowler, Bounded context and Ubiquitous language: https://martinfowler.com/bliki/BoundedContext.html , https://martinfowler.com/bliki/UbiquitousLanguage.html
- Gregor Hohpe, architecture is selling options: https://architectelevator.com/architecture/architecture-options/
- Michael Nygard, documenting architecture decisions: https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions
- C4 model (use levels 1 and 2 only on small projects): https://c4model.com/
- Refactoring Guru, design patterns catalog: https://refactoring.guru/design-patterns/catalog
- Matt Pocock, codebase-design skill (deletion test, seams): https://github.com/mattpocock/skills/tree/main/skills/engineering/codebase-design
- Armin Ronacher, "Simple code significantly outperforms complex code in agentic contexts.": https://lucumr.pocoo.org/2025/6/12/agentic-coding/
- Karpathy on models that "overcomplicate code and APIs": https://x.com/karpathy/status/2015883857489522876
- Simon Willison, vibe engineering: https://simonwillison.net/2025/Oct/7/vibe-engineering/
