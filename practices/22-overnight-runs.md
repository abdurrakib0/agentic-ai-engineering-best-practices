# 22. Overnight runs

## Problem

Agents can work while you sleep, but unattended runs go wrong in known ways: they try to do everything at once, run out of context halfway, declare "done" too early, loop on the same error, or burn money. In the morning you cannot tell what happened.

## Practice

Keep it simple. One recipe:

1. **Goal plus a check.** One clear goal and one command that proves each task is done (for example `npm test -- billing` or `npm run typecheck`).
2. **Task list file.** A short list of small tasks (PIPELINE.md works). The agent does one task at a time, top to bottom.
3. **One task per commit.** After each task passes its check, commit with a clear message.
4. **progress.md.** After each task, append two or three lines: what was done, what failed, what is next.
5. **Morning report.** At the end, write a short summary in progress.md: done, failed, needs a human.
6. **Sandbox and branch.** Run in a container or sandbox, on its own branch, never on main. Test credentials only ([practice 23](23-agent-safety.md)).
7. **Hard caps.** Run headless with `--max-turns` and `--max-budget-usd`.

**Minimal watchdog.** The caps above stop loops and runaway cost. Add one notify hook so you hear when the run stops. Optionally wrap the run in `timeout`. That is enough.

**Skip on purpose:** endless "Ralph" while loops, multi-agent planner/generator/evaluator harnesses, heartbeat daemons and dashboards. They add setup to maintain and are not needed for this recipe.

## Why

One task per commit and a progress file let you, or a fresh agent, see exactly where the run stopped and roll back any bad step. Caps turn "stuck all night" into "stopped after 30 minutes".

## Benefit

- Useful work done overnight, safely.
- A clear morning review: commits, progress.md and a short report.
- No surprise bills, no damage outside the sandbox.

## Example

Good overnight jobs: research, issue triage reports, small maintenance, well-specified tasks from a task list.

```bash
git switch -c overnight/2026-10-24
timeout 4h claude -p "$(cat overnight-prompt.md)" \
  --max-turns 200 --max-budget-usd 10 \
  --allowedTools "Read,Edit,Write,Bash(npm test *),Bash(npm run typecheck),Bash(git add *),Bash(git commit *)"
```

`overnight-prompt.md`:

```text
Work through TASKS.md from the top, one task at a time.
For each task: implement, run its check command, and commit only if it passes.
After each task, append 2 or 3 lines to progress.md.
If a task fails its check twice, mark it BLOCKED in progress.md and move on.
At the end, write a "Morning report" section: done, blocked, needs a human.
Never push. Never change tests to make them pass.
```

Notify hook (`.claude/settings.json`), Linux example:

```json
{ "hooks": { "Stop": [ { "hooks": [ { "type": "command",
  "command": "notify-send 'Agent run finished'" } ] } ] } }
```

## Sources

- Anthropic, Effective harnesses for long-running agents (one feature at a time, commit plus progress file, agents declaring done too early): https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- Claude Code docs, CLI reference (`--max-turns`, `--max-budget-usd`): https://code.claude.com/docs/en/cli-reference
- Claude Code docs, hooks guide (notifications): https://code.claude.com/docs/en/hooks-guide
- OpenAI Codex docs, non-interactive mode: https://developers.openai.com/codex/noninteractive
- Mitchell Hashimoto, end-of-day agents for research and triage: https://mitchellh.com/writing/my-ai-adoption-journey
- Simon Willison, Designing agentic loops (clear goal, sandbox, scoped credentials): https://simonwillison.net/2025/Sep/30/designing-agentic-loops/
- Skipped on purpose, for reference: Geoffrey Huntley, Ralph loop: https://ghuntley.com/ralph/
