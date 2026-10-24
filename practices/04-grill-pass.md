# 04. Grill pass

## Problem

User stories look complete until someone builds them. Then the gaps appear: empty states, permissions, limits, edge cases. An agent fills those gaps by guessing.

## Practice

- Before any build prompt, run a **grill pass** on the user stories and acceptance criteria.
- Ask an agent to find gaps and ask the owner questions. The agent asks, the owner answers.
- Answers go into the HANDOVER.md (as business rules or acceptance criteria) and into DECISIONS.md if they lock a choice.
- No build prompt until open questions are answered or explicitly marked out of scope.
- **Then start fresh.** Once the answers are in HANDOVER.md, build in a new session that reads the spec. The grill conversation stays out of the build context.

## Why

Questions are cheap before code and expensive after. Agents are good at spotting missing cases when asked to look for them, and bad at it when asked to build.

## Benefit

- Fewer rewrites and fewer surprise bugs.
- The owner's intent is written down, not guessed.
- Acceptance criteria become test cases directly.

## Example

Prompt:

> Here are the user stories and acceptance criteria for <module>. Do not write code. Ask me every question you need answered to build this without guessing. Group them by topic.

Day 0 group (new projects only, see [practice 24](24-day0-discovery-and-architecture.md)):

- **Appetite:** What is the time budget, and what gets cut if we run out?
- **Users and job:** Who is it for, and what job does it do?
- **Future:** Which 1 to 2 year directions are likely enough to design for now?
- **Scale:** Users, peak load, read or write heavy?
- **Sensitive data:** Money, personal data, minors? Which laws or policies apply?
- **Integrations:** Which outside systems?
- **Team:** Who maintains it, and in what stack?
- **Doors:** Which decisions are hard to reverse, and are they in DECISIONS.md?
- **Split check:** Does any module have a named level-up trigger? If not, it stays in the monolith.
- **Pattern check:** Does each abstraction have two real uses? If not, delete it.

Question list to cover (every module):

- **Who:** Which roles can do this? What does a user without permission see?
- **Data:** Which fields are required? Limits on length, count, size?
- **States:** Empty, loading, error, partial success?
- **Edges:** Duplicates? Deleted references? Concurrent edits?
- **Time:** Time zones? Deadlines? What happens when something expires?
- **Scale:** How many items? Pagination? Search?
- **Notify:** Who gets told when this changes, and how?
- **Undo:** Can it be reversed? Soft delete or hard delete?
- **Audit:** Do we need a history of who changed what?
- **Out of scope:** What will we explicitly not build now?

## Sources

- Claude Code docs, best practices ("Let Claude interview you", then implement in a fresh session): https://code.claude.com/docs/en/best-practices
