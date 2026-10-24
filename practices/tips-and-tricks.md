# Tips and tricks

Short, practical habits for working with coding agents. Each one is one or two lines plus a source.

## Before coding

- **Plan first.** Use plan mode, or ask for 2 or 3 approaches with pros and cons before any code. Pick one. [Karpathy](https://x.com/karpathy/status/1915581920022585597), [Claude Code docs](https://code.claude.com/docs/en/best-practices)
- **You own the shape.** Write the function signatures, schema or API spec yourself, then let the agent fill in the body. [Simon Willison](https://simonwillison.net/2025/Mar/11/using-llms-for-code/)
- **Show, do not describe.** Write a few lines in the right place and let the agent continue. It is often faster than explaining. [Karpathy](https://x.com/karpathy/status/1959703967694545296)
- **Talk to it like a coworker.** Say what you want, how much effort to spend, and how it should verify. [Boris Cherny](https://x.com/bcherny/status/2107565388250874193)
- **Give the reason and say what to do.** "Write flowing paragraphs" works better than "do not use bullets". Explain why a rule matters. [Anthropic prompting docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)
- **Be specific in one prompt:** the file, an existing pattern to copy, the symptom, and what "fixed" looks like. [Claude Code docs](https://code.claude.com/docs/en/best-practices)
- **Use XML tags for mixed input,** for example `<spec>`, `<error>`, `<diff>`, so instructions and data do not blur. [Anthropic prompting docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)

## While coding

- **Commit after every working step.** Press Esc to stop a wrong turn early and use rewind or git to roll back. [Karpathy](https://x.com/karpathy/status/1915581920022585597), [Claude Code docs](https://code.claude.com/docs/en/costs)
- **Say "do not touch unrelated code or comments".** Agents often change things outside the task. [Karpathy](https://x.com/karpathy/status/2015883857489522876)
- **Push back with "couldn't you just do X?"** It often turns a big solution into a small one. [Karpathy](https://x.com/karpathy/status/2015883857489522876)
- **Fresh start after two failed corrections.** Clear the session and write a better first prompt with what you learned. [Claude Code docs](https://code.claude.com/docs/en/best-practices)
- **Give the agent eyes.** A command to start the server, run tests or see the UI. [Boris Cherny](https://x.com/bcherny/status/2007202802154745888)
- **One script for common commands.** Put dev, test and lint in a Makefile or package scripts, and guard against starting a second server. [Armin Ronacher](https://lucumr.pocoo.org/2025/6/12/agentic-coding/)
- **Throwaway debug code is fine.** Let the agent write lots of temporary code to find a bug, then delete it. [Karpathy](https://x.com/karpathy/status/1959703967694545296)

## After coding

- **Ask for a cleanup pass.** Remove duplication, extra try/catch, nested ifs and dead code. [Karpathy](https://x.com/karpathy/status/1959703967694545296)
- **Ask for a plain explanation or a diagram** when you do not understand the output. [Karpathy](https://x.com/karpathy/status/2105819303471976479)
- **Hard bugs go to the strongest model with the full context.** [Karpathy](https://x.com/karpathy/status/1959703967694545296)
- **Be ready to take over by hand** when the agent is stuck. [Simon Willison](https://simonwillison.net/2025/Mar/11/using-llms-for-code/)
- **Ask for evidence, not claims.** "Show me the command output that proves it works" beats "is it done?". See the [verification-before-completion skill](../skills/third_party/verification-before-completion/). [Claude Code docs](https://code.claude.com/docs/en/best-practices)
