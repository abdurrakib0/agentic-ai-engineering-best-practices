# 14. Simplicity first

## Problem

Agents overbuild. They add layers, config systems, helper classes, defensive try/catch blocks and new dependencies nobody asked for. They rarely suggest deleting anything. The code grows, and every later change costs more to read and review.

## Practice

- **Do the dumbest thing that works.** Plain functions over classes, plain SQL over clever query layers, no inheritance tricks.
- **Build only what is needed now (YAGNI).** No "future-proof" abstractions, factories or config options for cases that do not exist yet.
- **Delete on purpose.** After each feature ask the agent: "What can we delete or simplify?" Remove dead code, unused helpers and unused files.
- **Boring, stable tech.** Prefer popular, well-known libraries. Agents know them best and make fewer mistakes with them. Upgrade conservatively.
- **Few dependencies.** Before adding a package, ask if a few lines of code would do the job.
- **Vanilla tooling.** Start with the agent's default setup. Add custom config, skills or tools only after a real, repeated need.
- **Agent-friendly code and tools.** Fast commands with short, clear errors. Logs go to a file the agent can read. Keep permission checks next to the route, not hidden in config, so the agent sees them.

## Why

Simple code is easier for agents to read, change and verify, and easier for you to review. Every extra layer is more context the agent must load and more places for it to guess wrong.

## Benefit

- Smaller, readable code.
- Fewer bugs from hallucinated APIs and broken upgrades.
- Less setup to maintain.

## Example

Prompts to keep the agent lean:

```text
Use the simplest approach that works. No new dependencies, no new abstractions.
Couldn't you just do X instead?
What in this change can we delete or simplify?
```

## Sources

- Karpathy on models that "overcomplicate code and APIs, they bloat abstractions" and leave dead code: https://x.com/karpathy/status/2015883857489522876
- Karpathy, nanochat README: "no giant configuration objects, model factories, or if-then-else monsters": https://github.com/karpathy/nanochat
- Armin Ronacher, simple code, plain SQL, few dependencies: https://lucumr.pocoo.org/2025/6/12/agentic-coding/
- Simon Willison, pick boring, stable libraries: https://simonwillison.net/2025/Mar/11/using-llms-for-code/
- Martin Fowler, YAGNI: https://martinfowler.com/bliki/Yagni.html
- Choose Boring Technology: https://boringtechnology.club/
- Boris Cherny (creator of Claude Code): "My setup might be surprisingly vanilla!": https://x.com/bcherny/status/2007179832300581177
- Reddit r/ExperiencedDevs, overengineering is the biggest AI problem: https://www.reddit.com/r/ExperiencedDevs/comments/1u1tgjq/the_biggest_problem_with_ai_is_not_correctness_it/
