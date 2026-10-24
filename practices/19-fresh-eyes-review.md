# 19. Fresh-eyes review for big or risky changes

## Problem

The agent that wrote the code is blind to its own wrong assumptions. Its context is full of the reasoning that led to the bug. Your own review ([practice 17](17-review-every-diff.md)) can also miss things on a large or sensitive diff.

## Practice

- **Use it only for big or risky changes:** auth and permissions, money and billing, database migrations, or a diff too large to review comfortably. Small changes do not need it.
- **Use a fresh session**, or a different model, with no history from the writer. Give it only the spec (HANDOVER.md) and the diff.
- **Ask for correctness gaps only:** bugs, missing permission checks, data loss, broken acceptance criteria. Not style, not "nice to have" ideas.
- **You decide what to fix.** The writer agent fixes only the findings you accept.

## Why

A clean context has no stake in the existing solution, so it spots gaps the writer explained away. Limiting it to correctness stops the reviewer from pushing the code toward overengineering.

## Benefit

- Catches serious bugs before they ship, where they cost the most.
- No review noise and no gold-plating.
- Cheap: one extra prompt, only when it matters.

## Example

```text
You are reviewing a change you did not write.
Spec: docs/modules/billing/HANDOVER.md
Diff: git diff origin/development...HEAD
List only correctness gaps: bugs, missing authz checks, data loss,
unmet acceptance criteria. For each, give file, line and why.
No style comments, no refactor ideas. If nothing is wrong, say so.
```

## Sources

- Claude Code docs, best practices (writer and reviewer sessions, adversarial review, and the warning that chasing every finding leads to over-engineering): https://code.claude.com/docs/en/best-practices
- Thariq (Claude Code team) on review in a fresh context: https://x.com/trq212/status/2008610538763559356
- Pawel Huryn on cross-model review: https://x.com/PawelHuryn/status/2063899498259128670
