# 04. Grill pass

## Problem

User stories look complete until someone builds them. Then the gaps appear: empty states, permissions, limits, edge cases. An agent fills those gaps by guessing.

## Practice

- Before any build prompt, run a **grill pass** on the user stories and acceptance criteria.
- Ask an agent to find gaps and ask the owner questions. The agent asks, the owner answers.
- Answers go into the HANDOVER.md (as business rules or acceptance criteria) and into DECISIONS.md if they lock a choice.
- No build prompt until open questions are answered or explicitly marked out of scope.

## Why

Questions are cheap before code and expensive after. Agents are good at spotting missing cases when asked to look for them, and bad at it when asked to build.

## Benefit

- Fewer rewrites and fewer surprise bugs.
- The owner's intent is written down, not guessed.
- Acceptance criteria become test cases directly.

## Example

Prompt:

> Here are the user stories and acceptance criteria for <module>. Do not write code. Ask me every question you need answered to build this without guessing. Group them by topic.

Question list to cover:

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
