# 07. Docs discipline

## Problem

Agents change behavior fast, and docs fall behind. Specs stop matching code, users do not know what changed, and the next agent reads stale docs and builds the wrong thing.

## Practice

- **README and CHANGELOG** are updated on every major change.
  - The PR template has a checkbox for each.
  - CI posts a warning when `src/` changes but `CHANGELOG.md` does not.
- **The CHANGELOG is the single source.** Release notes, the in-app "Latest updates" entry and user notifications are all drawn from it.
- **Notable user-facing changes only** (new features, changed workflows, removed features):
  - update the in-app user manual,
  - add a "Latest updates" entry from the CHANGELOG,
  - notify affected users.
- Small fixes and polish get a CHANGELOG line only.
- **Spec docs** (HANDOVER.md, contracts, DECISIONS.md) are updated in the same PR as the code.

## Why

For agents, docs are context. Stale docs produce wrong code. Tying doc updates to the PR makes them part of "done", not a later chore.

## Benefit

- Docs stay true, so agents and people can trust them.
- Users learn about changes without asking.
- Release notes write themselves from the CHANGELOG.

## Example

```yaml
# .github/workflows/docs-check.yml (warning only)
name: docs-check
on: pull_request
jobs:
  changelog:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - run: |
          CHANGED=$(git diff --name-only origin/${{ github.base_ref }}...HEAD)
          if echo "$CHANGED" | grep -q '^src/' && ! echo "$CHANGED" | grep -q '^CHANGELOG.md$'; then
            echo "::warning::src changed but CHANGELOG.md did not"
          fi
```
