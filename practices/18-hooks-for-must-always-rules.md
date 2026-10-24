# 18. Hooks for must-always rules

## Problem

A rule in AGENTS.md is advice. The agent usually follows it, but not always. For rules that must hold every single time, such as "format after every edit" or "never push", usually is not good enough.

## Practice

- **Use a hook for any rule that must never be skipped.** A hook is a small script the agent tool runs automatically before or after an action.
- **Start with two hooks:**
  - After each file edit: run the formatter.
  - Before each shell command: block dangerous git commands (push, `reset --hard`, `clean -f`, `branch -D`). The [git-guardrails skill](../skills/third_party/git-guardrails-claude-code/) sets this up.
- **Optional third hook: gitleaks before each commit.** A git pre-commit hook that runs `gitleaks git --pre-commit --staged` stops a secret before it ever reaches history ([practice 25](25-security-baseline.md)).
- **Keep everything else in AGENTS.md.** Add a hook only after a rule was broken more than once ([practice 17](17-review-every-diff.md)).
- **Keep hooks tiny and fast.** One script, one job, a clear message when it blocks.

## Why

Hooks are deterministic: they run every time, whatever the model decides. Moving hard rules into hooks also makes AGENTS.md shorter ([practice 10](10-tier0-agent-files.md)).

## Benefit

- Hard rules hold every time.
- Shorter agent files.
- No more "please format" or "do not push" reminders.

## Example

`.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      { "matcher": "Edit|Write",
        "hooks": [{ "type": "command",
          "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write" }] }
    ],
    "PreToolUse": [
      { "matcher": "Bash",
        "hooks": [{ "type": "command",
          "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh" }] }
    ]
  }
}
```

Proof it works: `echo '{"tool_input":{"command":"git push origin main"}}' | .claude/hooks/block-dangerous-git.sh` exits with code 2.

## Sources

- Claude Code docs, hooks guide: https://code.claude.com/docs/en/hooks-guide
- Claude Code docs, best practices ("Set up hooks"): https://code.claude.com/docs/en/best-practices
- Boris Cherny's setup, a PostToolUse hook to format code: https://www.reddit.com/r/ClaudeAI/comments/1q2c0ne/claude_code_creator_boris_shares_his_setup_with/
- Matt Pocock, git-guardrails-claude-code skill (MIT): https://github.com/mattpocock/skills
- gitleaks (pre-commit usage): https://github.com/gitleaks/gitleaks
