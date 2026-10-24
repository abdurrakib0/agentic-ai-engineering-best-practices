## What changed

<!-- One or two lines. Link the HANDOVER.md or PIPELINE.md row. -->

## Target

- [ ] Feature: targets `development`. Hotfix: targets `main`

## Gates

- [ ] typecheck, lint and tests pass
- [ ] check:authz passes (plus check:contracts and check:context if the project uses them)
- [ ] No tests were weakened, skipped, disabled or deleted
- [ ] No features, options or files added that were not asked for
- [ ] One logical change, with proof it works (a manual check plus one test that fails without it)

## Security

- [ ] Every new or changed route uses the shared `requirePermission` guard
- [ ] Identity comes from the session, never from the request body
- [ ] Inputs are parsed with a zod allowlist schema (no passthrough)
- [ ] Database reads use an explicit `select` (no secrets, hashes or emails leaked)
- [ ] Cron or internal routes check a secret and return 404 on a wrong one
- [ ] Permission changes invalidate session and cache instantly (refresh token rotation only if auth is custom built)
- [ ] Internal pages (manual, admin) are behind auth
- [ ] Sensitive routes (money, admin, permissions, cross-workspace): negative authz tests added
- [ ] Public routes are listed in the allowlist with a reason

- [ ] New dependency (if any): named here, confirmed it exists, checked downloads and release age, owner said yes
- [ ] No secrets in code, config or client-side variables (`NEXT_PUBLIC_`, `VITE_`)
- [ ] No raw HTML rendered without sanitizing
- [ ] No passwords, tokens or personal data in logs

## Docs

- [ ] README updated (if setup, scripts or behavior changed)
- [ ] CHANGELOG entry added
- [ ] Spec docs (HANDOVER.md, contracts, DECISIONS.md) match the code
- [ ] No feature built outside a locked requirement or spec
- [ ] Notable user-facing change: in-app manual updated, and "Latest updates" entry and notification drawn from the CHANGELOG

## Design

- [ ] UI matches the locked design (or N/A)
- [ ] Reused existing components where a pattern already exists
