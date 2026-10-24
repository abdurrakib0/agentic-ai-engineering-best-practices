# 23. Agent safety

## Problem

Agents follow instructions they find in content: a web page, an issue, a README, an email. If an agent can also read private data and send data out, one hidden instruction can leak secrets. Running agents with full permissions on your real machine and real keys makes any mistake expensive.

## Practice

- **Avoid the lethal trifecta.** Never give one agent all three at once:
  1. access to private data (code, secrets, customer data),
  2. exposure to untrusted content (web pages, issues, user input),
  3. a way to send data out (network, email, posting, pushing).
  Remove at least one. For example, an agent that reads web pages gets no secrets.
- **Sandbox before auto mode.** Skip-permission or auto modes run only inside a container or sandbox, never on your main machine.
- **Scoped test credentials.** Give agents test or staging keys with spending limits. Never production secrets, never your personal tokens.
- **Deny `.env` reads, and still sandbox.** Add `Read(./.env)`, `Read(./.env.local)` and `Read(./.env.*.local)` to the agent's deny rules. Deny rules do not cover every program the agent can run, so the sandbox is the real wall. Do not deny `.env.*`: that also hides `.env.example`, which agents need for variable names.
- **Trust MCP servers like dependencies.** Only from known publishers, pinned, read-only where possible, and turned off when unused.
- **AI in CI runs on trusted PRs only.** Never give an AI action secrets in a job that reads issue, PR or comment text from outsiders.
- **Fine-grained, expiring tokens.** Scope each token to one repo and the fewest permissions, with an expiry date.
- **Allowlist, do not trust.** Allow the commands the agent needs (tests, typecheck, git commit). Block the rest by default.

## Why

There is no reliable filter against prompt injection, so the safe move is to take away one of the three ingredients. A sandbox and scoped keys cap the damage of any mistake or attack.

## Benefit

- Secrets cannot leak through hidden instructions.
- Auto mode without approving every command.
- Worst case is a broken sandbox, not a broken company.

## Example

```text
Research agent:  reads the web      -> no repo secrets, no push rights
Coding agent:    reads repo + .env? -> no: test keys only, no web browsing
Overnight agent: sandbox container, test DB, key with a $10 limit, no push
```

## Sources

- Simon Willison, The lethal trifecta for AI agents: https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/
- Simon Willison, Designing agentic loops (YOLO mode only in a sandbox, tightly scoped credentials with budget limits): https://simonwillison.net/2025/Sep/30/designing-agentic-loops/
- Claude Code docs, sandboxing: https://code.claude.com/docs/en/sandboxing
- Anthropic engineering, Claude Code sandboxing: https://www.anthropic.com/engineering/claude-code-sandboxing
- Claude Code docs, permissions (deny rules): https://code.claude.com/docs/en/permissions
- Simon Willison, MCP prompt injection: https://simonwillison.net/2025/Apr/9/mcp-prompt-injection/
- MCP security best practices: https://modelcontextprotocol.io/docs/tutorials/security/security_best_practices
- Microsoft Security Blog, Securing CI/CD in an agentic world (2026-06-05): https://www.microsoft.com/en-us/security/blog/2026/06/05/securing-ci-cd-in-agentic-world-claude-code-github-action-case/
- Cloud Security Alliance, Comment and Control: https://labs.cloudsecurityalliance.org/research/csa-research-note-comment-control-github-prompt-injection-20/
- claude-code-action security docs: https://github.com/anthropics/claude-code-action/blob/main/docs/security.md
- Full baseline: [practice 25](25-security-baseline.md)
