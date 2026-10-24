# 10. Tier-0 agent files

## Problem

AGENTS.md or CLAUDE.md grows into a huge rulebook. It eats the context window, agents skim it, and important rules get lost.

## Practice

- Treat `AGENTS.md` / `CLAUDE.md` as **tier-0**: loaded every session, so keep it under a byte budget (for example **4 KB**).
- Tier-0 holds only: what the project is, the top rules, the gate commands and **pointers** to deeper docs.
- Full rules live in a separate operating-model doc (for example `docs/OPERATING_MODEL.md`), plus FOUNDATIONS.md, PIPELINE.md and the HANDOVER.md files.
- A CI check fails if tier-0 files exceed the budget.

## Why

Every byte in tier-0 is paid in every session. Short files get read fully. Pointers let the agent load deeper rules only when the task needs them.

## Benefit

- Rules always fit in context and get followed.
- More context left for the actual task.
- One place to update each rule.

## Example

```markdown
# AGENTS.md

Project: task manager web app (Next.js, Prisma, Postgres).

## Must
- Read PIPELINE.md, then your module's HANDOVER.md, before coding.
- Build nothing outside HANDOVER.md. Stop and ask if scope is unclear.
- Run: npm run typecheck && npm run lint && npm test && npm run check:authz
- Follow the security gate: docs/practices/06-security-gate.md

## Never
- force push, git stash, reset --hard, pkill -f
- read .env, weaken tests, touch other agents' branches

## More
- Full rules: docs/OPERATING_MODEL.md
- Stack and conventions: FOUNDATIONS.md
- Terms: GLOSSARY.md
```

```bash
# CI budget check
test $(wc -c < AGENTS.md) -le 4096 || { echo "AGENTS.md over 4 KB"; exit 1; }
```
