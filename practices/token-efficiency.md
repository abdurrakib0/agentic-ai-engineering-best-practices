# Token efficiency

Fewer wasted tokens means faster answers, lower cost and better focus. Each tip is one or two lines plus a source.

- **New session per task.** Long chats get slower, cost more and get distracted. Clear between unrelated tasks. [Karpathy](https://x.com/karpathy/status/1902737525900525657), [Claude Code docs](https://code.claude.com/docs/en/costs)
- **Short AGENTS.md / CLAUDE.md.** For each line ask "Would removing this cause Claude to make mistakes?" If not, cut it. Bloated files get ignored. [Claude Code docs](https://code.claude.com/docs/en/best-practices)
- **Move rare workflows into skills.** They load only when needed. Aim to keep CLAUDE.md under 200 lines. [Claude Code docs](https://code.claude.com/docs/en/costs)
- **Compact with a focus, or clear.** `/compact Focus on API changes` keeps what matters. Compacting is itself a big request, so use `/clear` when you do not need the history. [Claude Code docs](https://code.claude.com/docs/en/costs)
- **No log dumps.** Write logs to a file, keep them concise, and show only failing tests to the agent. [Armin Ronacher](https://lucumr.pocoo.org/2025/6/12/agentic-coding/), [Claude Code docs](https://code.claude.com/docs/en/costs)
- **Targeted reads.** Point the agent at the files that matter. Scope investigations narrowly, or use a subagent for wide searches so the main session stays clean. [Claude Code docs](https://code.claude.com/docs/en/best-practices)
- **CLI tools over MCP when possible.** Tools like `gh` add no per-tool listing to context. Disable MCP servers you are not using. [Claude Code docs](https://code.claude.com/docs/en/costs), [Armin Ronacher](https://lucumr.pocoo.org/2025/6/12/agentic-coding/)
- **Right-size the model.** The docs say "Sonnet handles most coding tasks well". Save the biggest model for hard design and use small models for simple subtasks. [Claude Code docs](https://code.claude.com/docs/en/costs)
- **Avoid long idle gaps mid-session.** After the cache expires, the next message reprocesses the whole context. [Claude Code docs](https://code.claude.com/docs/en/costs)
