# 20. Parallel agents

> Related: [practice 09, multi-agent rules](09-multi-agent-rules.md) has the isolation and safety rules.

## Problem

Running many agents at once sounds faster, but every result still needs your review. Too many agents leave you with a pile of unreviewed diffs, tests that break each other, and lost track of which branch holds what.

## Practice

- **Start with 2 or 3 agents.** Your review speed is the cap, not the machine. Add more only when you keep up.
- **Pick tasks that are cheap to review:** research and proof of concepts, "how does X work" questions, small maintenance (warnings, deprecations), and well-specified tasks with a HANDOVER.md.
- **Land one big change at a time.** Run small tasks in parallel around it.
- **Isolate each agent:** its own worktree and branch ([practice 09](09-multi-agent-rules.md)), plus its own dev server port and its own local database. Shared ports or databases make one agent's tests fail because of another agent's half-done work.
- **Keep a short task list** (PIPELINE.md or a few lines): task, agent, branch, status. Nothing gets lost.
- **Batch fan-out for repeated edits:** list the files, test the prompt on 2 or 3 of them, then loop over the rest with a headless run and restricted tools.

## Why

The bottleneck in agent work is human review. Parallel agents help only when their output is easy to check. Isolation removes the most common cause of confusing failures.

## Benefit

- More done per day without a review backlog.
- No agents breaking each other's tests or servers.
- Every branch is accounted for.

## Example

```bash
# lane per agent: worktree, branch, port, DB
git worktree add ../app-a -b agent-a/fix-warnings origin/development
cd ../app-a && PORT=3101 DATABASE_URL=postgres://localhost/app_a npm run dev

# batch fan-out after testing the prompt on 2 or 3 files
for f in $(cat files.txt); do
  claude -p "Migrate $f from the old logger to lib/log.ts. Run npm run typecheck." \
    --allowedTools "Edit,Bash(npm run typecheck)"
done
```

## Sources

- Simon Willison, Embracing the parallel coding agent lifestyle: https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- Simon Willison, losing track of a feature across worktrees: https://x.com/simonw/status/2024622269902049631
- Claude Code docs, best practices ("Fan out across files"): https://code.claude.com/docs/en/best-practices
- Boris Cherny's setup (several sessions in parallel, numbered tabs, notifications): https://www.reddit.com/r/ClaudeAI/comments/1q2c0ne/claude_code_creator_boris_shares_his_setup_with/
- Armin Ronacher, keep shared state like databases separated between agents: https://lucumr.pocoo.org/2025/6/12/agentic-coding/
- Mitchell Hashimoto, runs one agent at a time by choice: https://mitchellh.com/writing/my-ai-adoption-journey
