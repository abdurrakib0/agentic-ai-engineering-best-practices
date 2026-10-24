# 05. Glossary

## Problem

One concept ends up with many names: user, member, account, person. Each agent picks a different one, and code, UI and docs stop matching.

## Practice

- Keep one `GLOSSARY.md` with **one standard term per concept**.
- For each term: meaning, the name to use in code, and banned synonyms.
- Add new terms to the glossary **before** using them.
- A `check:glossary` (or part of `check:context`) script warns when a banned synonym appears in code, UI strings or docs.

## Why

Agents copy the words they see. If the glossary and the code agree, new code follows. A shared vocabulary between the business and the code also makes specs easier to read.

## Benefit

- Consistent names across agents, modules, UI and docs.
- Easier search and refactoring.
- Business people and developers mean the same thing by the same word.

## Example

Template: [templates/GLOSSARY.md](../templates/GLOSSARY.md).

```js
// scripts/check-glossary.mjs (warns, does not fail)
import { execSync } from "node:child_process";

const banned = { user: "member", tenant: "workspace", ticket: "task" };
for (const [bad, good] of Object.entries(banned)) {
  try {
    const hits = execSync(`git grep -niw "${bad}" -- src docs`, { encoding: "utf8" });
    console.warn(`Use "${good}" instead of "${bad}":\n${hits}`);
  } catch { /* no hits */ }
}
```
