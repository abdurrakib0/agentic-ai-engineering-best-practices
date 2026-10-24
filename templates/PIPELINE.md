# PIPELINE

> The agent queue. Agents work top to bottom. Update this file in every commit.

## Gates (all must pass before a merge)

- [ ] `npm run typecheck`
- [ ] `npm run lint`
- [ ] `npm test`
- [ ] `npm run check:authz`

Optional (add only when needed):

- [ ] `npm run check:contracts`
- [ ] `npm run check:context`

## Build order

| # | Module / task | Spec | Branch | Agent | Status |
|---|---------------|------|--------|-------|--------|
| 1 | contracts: <module> | docs/<module>/HANDOVER.md | agent-a/<module>-contracts | agent-a | todo |
| 2 | api: <module> | docs/<module>/HANDOVER.md | agent-a/<module>-api | agent-a | todo |
| 3 | ui: <module> | docs/<module>/HANDOVER.md | agent-b/<module>-ui | agent-b | blocked by 2 |

Status: todo | in progress | review | merged | blocked

## Merge order

1. Migrations (applied by the lead dev)
2. Contracts
3. Server
4. Client

## Commit checkpoints

Commit after each step that passes the gates. Message format:

```
<module>: <step> [checkpoint N]
```

## Resume steps (for a fresh agent)

1. Read AGENTS.md, then this file.
2. Find the first row that is not `merged`.
3. Read its HANDOVER.md.
4. `git log --oneline -10` on its branch to find the last checkpoint.
5. Run the gates. Continue from the next unchecked step.

## Stop rules

Stop and ask the owner when:

- The task needs something outside the HANDOVER.md scope.
- A gate fails twice for the same reason.
- A test would need to be weakened, skipped or deleted.
- The work would add a feature or file nobody asked for.
- A migration, secret or production setting is involved.
- Two specs disagree.

## Log

| Date | Agent | Row | Note |
|------|-------|-----|------|
| | | | |
