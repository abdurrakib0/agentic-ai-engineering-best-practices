# 09. Multi-agent rules

## Problem

Several agents in one repo step on each other: shared working directories, force pushes, killed dev servers, overloaded machines and broken shared databases.

## Practice

**Isolation**
- One git worktree and one branch per agent, prefix-scoped (for example `alex/*`, `agent-a/*`).
- Agents never merge into the integration branch. A human lead merges.
- Local throwaway database only. Never a shared or production DB.

**Safe git**
- No `git push --force`, `git stash` or `git reset --hard`.
- Retarget stale PRs to the new base without rebasing.
- Check the PR head SHA before reporting status, so the report matches what was actually pushed.

**Safe processes**
- No `pkill -f`. Kill only by exact PID.
- Run only the dev servers you need, and stop your own when done.
- If the machine slows down, pause extra agents instead of adding more.

**Safe code**
- Never read `.env` or secret files.
- Never weaken, skip, disable or delete tests to make a gate pass.
- Never add features, options or files that were not asked for.
- Migrations are ordered and applied by the lead dev **before** the code that needs them deploys.

## Why

Agents run commands literally and fast. A broad command like `pkill -f node` or `reset --hard` can destroy another agent's work in a second. Narrow rules keep each agent inside its own lane.

## Benefit

- Agents can work in parallel without breaking each other.
- No lost work from force pushes or stashes.
- Machines stay responsive.
- Secrets and real data stay safe.

## Example

```bash
# start a new agent lane
git worktree add ../repo-agent-a -b agent-a/tasks-api origin/development

# stop only your own server
kill 48213   # exact PID, never pkill -f

# before reporting
gh pr view 123 --json headRefOid -q .headRefOid
```
