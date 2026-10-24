# DECISIONS

> Dated log of locked decisions. Newest on top. Agents read this before building.
> A locked item changes only with a new dated entry approved by the owner.
> Log one-way doors (hard to undo: database, auth, tenancy, hosting, major vendor, public API shape). Two-way doors are just decided.

| ID | Date | Decision | Status | Approved by | Supersedes |
|----|------|----------|--------|-------------|------------|
| D-003 | YYYY-MM-DD | Auth: managed provider, no custom auth | locked | owner | |
| D-002 | YYYY-MM-DD | Tenancy: one database, workspace_id on every row | locked | owner, lead dev | |
| D-001 | YYYY-MM-DD | Database: Postgres | locked | owner | |

Status: proposed | locked | superseded

## Entry format

```
### D-00N: <title> (YYYY-MM-DD)
Door: one-way | two-way (only one-way needs Options)
Context: [Fact] ... [Assumption] ...
Options: A ..., B ...
Decision: [Recommendation] A, because ...
Locked by: owner
```
