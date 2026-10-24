## What changed

<!-- One or two lines. Link the HANDOVER.md or PIPELINE.md row. -->

## Target

- [ ] Feature: targets `development`. Hotfix: targets `main`

## Gates

- [ ] typecheck, lint and tests pass
- [ ] check:authz, check:context and check:contracts pass
- [ ] No tests were weakened, skipped or deleted

## Security

- [ ] Every new or changed route uses the shared `requirePermission` guard
- [ ] Identity comes from the session, never from the request body
- [ ] Inputs are parsed with a zod allowlist schema (no passthrough)
- [ ] Database reads use an explicit `select` (no secrets, hashes or emails leaked)
- [ ] Cron or internal routes check a secret and return 404 on a wrong one
- [ ] Refresh tokens rotate; permission changes invalidate session and cache instantly
- [ ] Internal pages (manual, admin) are behind auth
- [ ] Negative authz tests added (wrong role, no session, other workspace)
- [ ] Public routes are listed in the allowlist with a reason

## Docs

- [ ] README updated (if setup, scripts or behavior changed)
- [ ] CHANGELOG entry added
- [ ] Spec docs (HANDOVER.md, contracts, DECISIONS.md) match the code
- [ ] No feature built outside a locked requirement or spec
- [ ] User-facing change: in-app user manual updated
- [ ] User-facing change: "Latest updates" entry added and notification sent

## Design

- [ ] UI matches the locked design (or N/A)
- [ ] Reused existing components where a pattern already exists
