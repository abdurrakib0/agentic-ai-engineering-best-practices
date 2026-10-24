# 13. Requirements and decisions

## Problem

Agents are eager. If a requirement is fuzzy, they invent a feature. If a decision is not written down, it gets reopened or forgotten.

## Practice

- **Order of locks:** requirements locked with the owner, then the spec is written and locked, then build starts.
- **Agents never invent features.** If it is not in a locked requirement or spec, it is not built.
- **DECISIONS.md** is a dated decision log. Each lock gets an entry: what, when, who approved, what it replaces.
- **Door: one-way or two-way.** Each entry says which. One-way doors (hard to undo: database, auth, tenancy, hosting, major vendor, public API shape) list the options considered. Two-way doors are just decided and need no options, often no entry at all ([practice 24](24-day0-discovery-and-architecture.md)).
- **Label claims** in big or risky specs and agent reports (optional for small specs, where marking open questions as [Assumption] is enough):
  - **[Fact]** verified (checked in code, data or with the owner)
  - **[Assumption]** believed but not verified
  - **[Inference]** derived from facts
  - **[Recommendation]** a proposal that needs an owner decision
- Only [Fact] and owner-approved items are buildable. Assumptions get confirmed in the [grill pass](04-grill-pass.md).

## Why

Labels make uncertainty visible, so the owner knows exactly what to confirm. A dated log stops the same decision from being argued again, and tells every agent what is settled.

## Benefit

- No surprise features.
- Faster reviews: the owner only checks assumptions and recommendations.
- A clear history of why things are the way they are.

## Example

Template: [templates/DECISIONS.md](../templates/DECISIONS.md).

```markdown
### D-007: Soft delete for tasks (2026-02-03)
Door: one-way (deleted data cannot come back)
Context: [Fact] Tasks are referenced by comments. [Assumption] Users want undo.
Options: A soft delete with 30 day restore, B hard delete
Decision: [Recommendation] A. Owner approved.
Locked by: owner
```

## Sources

- Amazon 2015 shareholder letter, one-way vs two-way doors: https://s2.q4cdn.com/299287126/files/doc_financials/annual/2015-Letter-to-Shareholders.PDF
- Michael Nygard, documenting architecture decisions: https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions
