# 03. Pipeline

## Problem

With several tasks and agents, nobody knows what is next, what is blocked, or where a session stopped. Work repeats or gets merged in the wrong order.

## Practice

- Keep one `PIPELINE.md` at the repo root. It is the **agent queue**.
- It lists: build order, merge order, gates, commit checkpoints, resume steps and stop rules.
- Core gates before every merge: `typecheck`, `lint`, `test`, `check:authz`.
- Optional gates: `check:contracts` and `check:context`. Add them only when the project is big enough to need them, and drop any gate that never catches a real problem. In a small app, shared contract types already make `typecheck` catch most drift.
- Agents commit at each checkpoint that passes the gates, and update PIPELINE.md in the same commit.
- Stop rules say exactly when an agent must stop and ask the owner.

## Why

Agents lose memory between sessions. A file in git does not. If the plan and the progress live in the repo, any fresh agent can resume from the last checkpoint.

## Benefit

- Work is resumable after a crash, a timeout or a new session.
- Merges happen in a safe order (migrations, contracts, server, client).
- Gates catch broken work before it lands.
- The owner sees progress at a glance.

## Example

Full template: [templates/PIPELINE.md](../templates/PIPELINE.md).

```markdown
## Stop rules
Stop and ask the owner when:
- The task needs something outside HANDOVER.md
- A gate fails twice for the same reason
- A test would need to be weakened, skipped or deleted
- A migration, secret or production setting is involved
```
