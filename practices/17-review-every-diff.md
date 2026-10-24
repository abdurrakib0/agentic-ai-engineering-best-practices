# 17. Review every diff and fix the setup

## Problem

Agents make wrong assumptions, edit code and comments unrelated to the task, and repeat the same mistakes across sessions. If nobody reads the diff, this damage ships silently.

## Practice

- **Read every diff for real code.** "Vibe coding" (accepting without reading) is only for throwaway projects.
- **Watch for warning signs:** loops on the same error, edits to unrelated files, features you did not ask for, and tests being weakened. Stop the agent early when you see them.
- **Ask for a cleanup pass** before merging: remove duplication, extra try/catch, nested ifs and dead code.
- **Fix the setup, not just the bug.** When the agent makes the same mistake twice, add one line to AGENTS.md or one small check script so it cannot happen again.
- **Give the agent a tool instead of a rule when you can.** If it keeps guessing, add a small script it can run (filtered test output, a screenshot, a lint rule). For rules that must never be skipped, use a hook ([practice 18](18-hooks-for-must-always-rules.md)).
- **Add a rule only after a real repeated failure.** Do not write rules for problems you have not had.

## Why

Agents are fast but have little taste and do not ask enough questions. Your review is the quality gate. Turning repeat mistakes into one-line rules makes every future session better without a big rulebook.

## Benefit

- Silent damage is caught before merge.
- The same mistake does not happen twice.
- Rules stay short because each one earned its place.

## Example

```text
Review this diff. List anything unrelated to the task, any dead code,
and anything we could delete. Do not change code yet.
```

## Sources

- Karpathy, vibe coding is "not too bad for throwaway weekend projects": https://x.com/karpathy/status/1886192184808149383
- Karpathy, models make wrong assumptions and change unrelated code: https://x.com/karpathy/status/2015883857489522876
- Karpathy, cleanup passes for code taste: https://x.com/karpathy/status/1959703967694545296
- Kent Beck, warning signs when the AI goes off track: https://tidyfirst.substack.com/p/augmented-coding-beyond-the-vibes
- Mitchell Hashimoto, turn each agent mistake into an AGENTS.md update or a check: https://mitchellh.com/writing/my-ai-adoption-journey
- Reddit r/ExperiencedDevs, locally reasonable AI choices cause architecture drift: https://www.reddit.com/r/ExperiencedDevs/comments/1s3f06x/ai_agents_pass_the_tests_but_break_the/
- OpenAI, Harness engineering (improve the environment and tools so agent mistakes do not repeat): https://openai.com/index/harness-engineering/
