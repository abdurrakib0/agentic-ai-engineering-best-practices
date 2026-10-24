# 25. Security baseline

## Problem

AI-built apps leak in the same few ways: secrets committed to git, keys shipped to the browser, packages that were just published by an attacker or that the model made up, missing rate limits, raw HTML in pages, and AI tools in CI that read untrusted text while holding secrets. None of these need a security team to fix. They need a short baseline set up once.

## Practice

Ten must-haves. About half a day of setup in total, then they run on their own.

1. **Secret scanning.** `.env` in `.gitignore`, a committed `.env.example`, gitleaks as a pre-commit hook and in CI, and GitHub push protection on.
2. **Secrets server-side and away from the agent.** Deny the agent `Read(./.env)` and `Read(./.env.*)`. No secrets in `NEXT_PUBLIC_` or `VITE_` variables. Service-role keys only on the server. If you use Supabase, turn on Row Level Security.
3. **Pinned and delayed dependencies.** Commit the lockfile, install with `npm ci`, turn on Dependabot security updates, and wait 3 to 7 days before taking a brand-new release (npm `min-release-age`, pnpm `minimumReleaseAge`, Dependabot `cooldown`).
4. **Agent asks before adding any package.** Models invent package names, and attackers register them (slopsquatting). In one study, 19.7% of recommended packages did not exist, and 43% of those made-up names came back on every rerun.
5. **One free code scanner.** CodeQL default setup for public repos, Semgrep Community Edition for private ones. One is enough.
6. **Rate limits and spend caps.** Rate limit login, OTP, password reset, costly and LLM routes. Set a spend cap at every paid provider.
7. **Safe browser defaults.** No raw HTML without DOMPurify. Cookies `HttpOnly`, `Secure`, `SameSite=Lax`. Headers: HSTS, `X-Content-Type-Options: nosniff`, `frame-ancestors`, `Referrer-Policy`. Add a CSRF token only for cookie-auth forms that can be posted cross-site.
8. **Clean logs and generic errors.** Never log passwords, tokens, keys or full personal data. Users see a generic error; details stay in the server log.
9. **Least privilege everywhere.** Fine-grained tokens with an expiry date. Workflows default to `permissions: contents: read`. Require approval before workflows run for outside contributors. AI actions in CI run only on trusted PRs, and never with secrets where they read issue or PR text. MCP servers only from known publishers, pinned, read-only where possible, and turned off when unused.
10. **SECURITY.md and private reporting.** One short file that says how to report a hole privately, and GitHub private vulnerability reporting turned on.

### Only when the feature exists

Add these only if your app has the feature. Skip the rest.

- **Data you cannot lose:** automatic backups, and one test restore.
- **Webhooks:** verify the signature, and make the handler idempotent (same event twice does nothing new).
- **Server fetches user-given URLs:** an allowlist of hosts (SSRF).
- **File uploads:** allowlist file types, cap size, rename files, store outside the web root.
- **AI features:** treat model output as untrusted, keep secrets out of prompts, and require a human approval before the AI sends, pays or deletes anything.
- **Admin panel:** MFA for admins and an audit log of admin actions.
- **Content Security Policy:** start in report-only mode, then enforce.
- **Risky PRs (auth, money, migrations):** run `/security-review` in Claude Code, on top of the [fresh-eyes review](19-fresh-eyes-review.md).

## Why

- These ten cover the most common real leaks in agent-built apps. Each one is a config line or a small file, not a project.
- Hard rules run as hooks and CI jobs, so they hold every time ([practice 18](18-hooks-for-must-always-rules.md)), not only when someone remembers.
- Agents read whatever is in reach and follow instructions hidden in content. Keeping secrets out of reach removes the prize ([practice 23](23-agent-safety.md)).

## Benefit

- Secrets stay out of git, out of the browser and out of the agent's context.
- New malicious or made-up packages do not slip in.
- Bots cannot run up your bill or brute force logins.
- Outsiders have a private way to report a problem.
- No extra tools, paid scanners or security process to maintain.

## Example

`.claude/settings.json`:

```json
{
  "permissions": {
    "deny": ["Read(./.env)", "Read(./.env.*)"]
  }
}
```

`.npmrc` (wait 5 days before installing a new release):

```ini
min-release-age=5
```

`.github/dependabot.yml`:

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    cooldown:
      default-days: 5
```

`.github/workflows/security.yml` (this repo uses the same file):

```yaml
name: security
on: [pull_request, push]
permissions: { contents: read }
jobs:
  secrets:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - run: docker run --rm -v "$PWD:/repo" ghcr.io/gitleaks/gitleaks:latest git /repo --redact
  deps:
    if: github.event_name == 'pull_request'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/dependency-review-action@v4
```

## Checklist

- [ ] `.env` ignored, `.env.example` committed, gitleaks in pre-commit and CI, push protection on
- [ ] Agent denied `.env` reads; no secrets in `NEXT_PUBLIC_` or `VITE_`; service keys server-only
- [ ] Lockfile committed, `npm ci` in CI, Dependabot security updates, 3 to 7 day release-age wait
- [ ] Agent asks before adding any package; the package exists and is not brand new
- [ ] One free scanner on (CodeQL or Semgrep CE)
- [ ] Rate limits on auth, OTP, costly and LLM routes; spend caps at every paid provider
- [ ] No raw HTML without DOMPurify; safe cookie flags and security headers
- [ ] No secrets or full personal data in logs; generic errors for users
- [ ] Fine-grained expiring tokens; workflows `contents: read`; AI in CI on trusted PRs only
- [ ] SECURITY.md committed and private reporting on

## Sources

- OWASP Top 10 (2025): https://owasp.org/Top10/2025/
- OWASP API Security, API4:2023 Unrestricted resource consumption: https://owasp.org/API-Security/editions/2023/en/0xa4-unrestricted-resource-consumption/
- OWASP Top 10 for LLM applications: https://genai.owasp.org/llm-top-10/
- OWASP cheat sheets: XSS prevention https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html , HTTP headers https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html , CSRF prevention https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html , Logging https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html , SSRF prevention https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html , File upload https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html
- GitHub docs, push protection: https://docs.github.com/en/code-security/secret-scanning/introduction/about-push-protection
- GitHub docs, CodeQL default setup: https://docs.github.com/en/code-security/code-scanning/enabling-code-scanning/configuring-default-setup-for-code-scanning
- GitHub docs, Dependabot options (cooldown): https://docs.github.com/en/code-security/dependabot/working-with-dependabot/dependabot-options-reference
- GitHub docs, secure use of Actions: https://docs.github.com/en/actions/reference/security/secure-use
- GitHub docs, security policy: https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository
- GitHub docs, private vulnerability reporting: https://docs.github.com/en/code-security/security-advisories/working-with-repository-security-advisories/configuring-private-vulnerability-reporting-for-a-repository
- npm config, min-release-age: https://docs.npmjs.com/cli/v11/using-npm/config
- pnpm settings, minimumReleaseAge: https://pnpm.io/settings
- gitleaks: https://github.com/gitleaks/gitleaks
- Semgrep Community Edition: https://github.com/semgrep/semgrep
- DOMPurify: https://github.com/cure53/DOMPurify
- Socket, slopsquatting ("19.7% of all recommended packages didn't exist"): https://socket.dev/blog/slopsquatting-how-ai-hallucinations-are-fueling-a-new-class-of-supply-chain-attacks
- Spracklen et al., package hallucinations by code LLMs: https://arxiv.org/abs/2406.10279
- Claude Code docs, permissions: https://code.claude.com/docs/en/permissions
- Claude Code docs, security: https://code.claude.com/docs/en/security
- Microsoft Security Blog, Securing CI/CD in an agentic world (2026-06-05): https://www.microsoft.com/en-us/security/blog/2026/06/05/securing-ci-cd-in-agentic-world-claude-code-github-action-case/
- Cloud Security Alliance, Comment and Control research note: https://labs.cloudsecurityalliance.org/research/csa-research-note-comment-control-github-prompt-injection-20/
- claude-code-action security docs: https://github.com/anthropics/claude-code-action/blob/main/docs/security.md
- Simon Willison, MCP prompt injection: https://simonwillison.net/2025/Apr/9/mcp-prompt-injection/
- MCP security best practices: https://modelcontextprotocol.io/docs/tutorials/security/security_best_practices
