# 10. Tier-0 agent files

> Related: [token efficiency](token-efficiency.md) has more ways to keep context small.

## Problem

AGENTS.md or CLAUDE.md grows into a huge rulebook. It eats the context window, agents skim it, and important rules get lost.

## Practice

- Treat `AGENTS.md` / `CLAUDE.md` as **tier-0**: loaded every session, so keep it under a byte budget (for example **4 KB**).
- Tier-0 holds only: what the project is, the top rules, the gate commands and **pointers** to deeper docs.
- Full rules live in a separate operating-model doc (for example `docs/OPERATING_MODEL.md`), plus FOUNDATIONS.md, PIPELINE.md and the HANDOVER.md files.
- A CI check fails if tier-0 files exceed the budget.
- **Prune with one question.** For each line ask: "Would removing this cause the agent to make mistakes?" If not, cut it. Drop anything the agent can learn by reading the code.
- **Move workflow detail into skills** (or deeper docs) that load only when needed, such as release steps or migration steps.
- **Add a line only after a real, repeated mistake** ([practice 17](17-review-every-diff.md)).

## Why

Every byte in tier-0 is paid in every session, and long files make agents ignore rules. Short files get read fully. Pointers let the agent load deeper rules only when the task needs them.

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
- read .env, touch other agents' branches
- delete, skip or disable tests; add features that were not asked for

## More
- Full rules: docs/OPERATING_MODEL.md
- Stack and conventions: FOUNDATIONS.md
- Terms: GLOSSARY.md
```

```bash
# CI budget check
test $(wc -c < AGENTS.md) -le 4096 || { echo "AGENTS.md over 4 KB"; exit 1; }
```

## Sources

- Claude Code docs, keep CLAUDE.md short and prune it: https://code.claude.com/docs/en/best-practices
- Claude Code docs, move rare instructions into skills: https://code.claude.com/docs/en/costs
