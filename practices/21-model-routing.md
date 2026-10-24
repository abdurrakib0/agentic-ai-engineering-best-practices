# 21. Model routing

## Problem

Using the biggest model for everything is slow and expensive. Using the cheapest model for everything gives weak plans and missed bugs. Model names change every few months, so rules tied to one name go stale.

## Practice

Route by model class, not by name:

| Task | Model class |
|------|-------------|
| Planning, architecture, spec review | Top model |
| Hard bugs, risky changes, fresh-eyes review ([practice 19](19-fresh-eyes-review.md)) | Top model |
| Routine coding from a clear spec | Mid model |
| Search, reading files, summaries, docs, simple edits in subagents | Small model |

- **Change effort before changing models.** Most tools let you raise or lower reasoning effort. Try that first.
- **Start mid, step up when stuck.** If the mid model fails twice on the same task, switch to the top model with the full context.
- **Set it once.** Put the model in subagent configs or tool settings, so you do not decide by hand every time.

## Why

Most coding work does not need the top model, but planning and hard bugs do: a bad plan costs far more than the tokens saved. Effort settings trade cost and quality inside one model, which is often enough.

## Benefit

- Lower cost and faster runs for routine work.
- Best quality where mistakes are expensive.
- Rules that survive new model releases.

## Example

Claude Code subagent (`.claude/agents/file-search.md`):

```markdown
---
name: file-search
description: Find where something is defined or used. Read only.
model: haiku
tools: Read, Grep, Glob
---
Return file paths and line numbers with one line of context each.
```

Claude Code also has an `opusplan` setting: top model in plan mode, mid model for execution.

## Sources

- Anthropic docs, choosing a model ("Tuning effort is often a better lever than switching models."): https://platform.claude.com/docs/en/about-claude/models/choosing-a-model
- Claude Code docs, model configuration and `opusplan`: https://code.claude.com/docs/en/model-config
- Claude Code docs, manage costs ("Sonnet handles most coding tasks well", small model for simple subagent tasks): https://code.claude.com/docs/en/costs
- Claude Code docs, subagents: https://code.claude.com/docs/en/sub-agents
- OpenAI Codex docs, models and reasoning effort: https://developers.openai.com/codex/models
- Simon Willison, let the main model pick a lower power model for subagents: https://x.com/simonw/status/2073117641020215566
