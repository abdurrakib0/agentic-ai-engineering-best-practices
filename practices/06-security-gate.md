# 06. Security gate

## Problem

Agents ship working code that is not safe: missing permission checks, trusting IDs from the client, returning whole database rows, open cron routes. These holes are easy to miss in review.

## Practice

Every feature, API and page passes the same gate. For repo-wide setup (secret scanning, dependencies, headers, tokens), see the [security baseline](25-security-baseline.md).

- **One shared guard.** Every server route calls `requirePermission(session, "<module>:<action>")`. No hand-rolled checks.
- **Never trust identity from the client.** Fields like `assignedById` or `createdById` come from the session, never from the request body.
- **Allowlist inputs.** Parse every input with a strict zod schema. Unknown keys are rejected.
- **Explicit select.** Database reads use an explicit field list (for example Prisma `select`). Never return password hashes, tokens, secrets or other people's emails.
- **Cron and internal routes** require a secret. A wrong or missing secret returns **404**, not 401, so the route is not discoverable.
- **Refresh token rotation.** If you use a managed auth library or provider, rely on its session handling. Only if you build auth yourself: each refresh issues a new token and invalidates the old one, and reuse of an old token revokes the session.
- **Permission changes apply instantly.** When a role or permission changes, invalidate the session and permission cache for that user right away.
- **Internal pages behind auth.** User manuals, admin pages and any page with internal content require login. Nothing internal is public.
- **Negative authz tests on sensitive routes.** For routes that touch money, admin actions, permissions or data across workspaces, test wrong role, no session and another workspace's data. All must fail. For other routes, the shared guard plus `check:authz` is enough.
- **Keep checks local and visible.** Call the guard inline at the top of each route, so a person or agent reading the route sees the permission right there.
- **PR checklist** with security items (see [templates/PR_TEMPLATE.md](../templates/PR_TEMPLATE.md)).
- **CI `check:authz`.** Fails if a route does not call the guard, unless it is in a short public allowlist with a reason per entry.

## Why

Agents follow patterns. If there is one guard and one checklist, every new route copies the safe pattern. CI catches the cases where they do not. Heavy tests go where a hole would hurt most, not on every route.

## Benefit

- Fewer security holes, found earlier.
- Reviews are faster: check the list, not the whole diff.
- Public surface is small and documented.

## Example

```ts
// server/auth/requirePermission.ts
export async function requirePermission(req: Request, perm: string) {
  const session = await getSession(req);
  if (!session) throw new HttpError(401);
  if (!session.permissions.includes(perm)) throw new HttpError(403);
  return session;
}

// route
const session = await requirePermission(req, "tasks:create");
const input = CreateTaskInput.parse(await req.json());
const task = await db.task.create({
  data: { ...input, assignedById: session.memberId }, // from session, not body
  select: { id: true, title: true, assigneeId: true, createdAt: true },
});
```

```ts
// cron route
if (req.headers.get("x-cron-secret") !== process.env.CRON_SECRET) {
  return new Response(null, { status: 404 });
}
```

```yaml
# authz-allowlist.yml (public routes, reason required)
- route: /api/health
  reason: Uptime monitor
- route: /api/auth/login
  reason: Login must be public
```

## Checklist

- [ ] Route calls `requirePermission` with the right permission
- [ ] No identity fields taken from the request body
- [ ] Input parsed with a strict zod schema
- [ ] DB reads use explicit `select`
- [ ] Cron or internal route returns 404 on wrong secret
- [ ] Refresh tokens rotate (only if auth is custom built)
- [ ] Permission change invalidates session and cache instantly
- [ ] Internal pages (manuals, admin) are behind auth
- [ ] Sensitive route: negative authz tests (no session, wrong role, other workspace)
- [ ] Public routes listed in the allowlist with a reason
- [ ] Rate limit on auth, OTP and costly routes
- [ ] No raw HTML rendered without sanitizing (DOMPurify)

## Sources

- Armin Ronacher, keep permission checks local and visible to the agent: https://lucumr.pocoo.org/2025/6/12/agentic-coding/
