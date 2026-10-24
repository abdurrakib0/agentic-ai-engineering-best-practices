# Agentic AI Engineering Best Practices

**Practical rules, templates and checklists for building real software with AI coding agents.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Last commit](https://img.shields.io/github/last-commit/abdurrakib0/agentic-ai-engineering-best-practices)](https://github.com/abdurrakib0/agentic-ai-engineering-best-practices/commits/main)

Maintained by Abdur Rakib ([@abdurrakib0](https://github.com/abdurrakib0)).

---

## Why this exists

AI coding agents write code fast. Projects still fail, and usually for the same four reasons:

| Failure | What happens |
|---------|--------------|
| **Context ceiling** | The agent cannot hold the whole system in its head, so it guesses. |
| **Interface drift** | Client and server, or two modules, slowly stop agreeing on shapes and names. |
| **Blast radius** | One change touches too much, and one bad change breaks everything. |
| **No resumability** | A new session cannot tell where the last one stopped, so work repeats or gets lost. |

The bottleneck is not the model. It is **architecture and process**. This repo collects the process that fixes those four problems: clear specs, shared contracts, hard gates and simple rules every agent follows.

## Who this is for

- Developers who build with Claude Code, Cursor, Codex or any coding agent.
- Tech leads running several agents (or several people plus agents) on one repo.
- Founders and product owners who want agent speed without losing control of scope and security.
- Teams onboarding new people who need one clear way of working.

## Table of contents

| # | Practice | What | Why it helps |
|---|----------|------|--------------|
| 01 | [Module handover specs](practices/01-module-handover-specs.md) | One HANDOVER.md per module; agents build nothing outside it | Beats the context ceiling and stops scope creep |
| 02 | [Shared API contracts](practices/02-shared-api-contracts.md) | Zod schemas shared by client and server, checked in CI | Ends interface drift |
| 03 | [Pipeline](practices/03-pipeline.md) | PIPELINE.md as the agent queue, gates and resume steps | Makes work resumable and ordered |
| 04 | [Grill pass](practices/04-grill-pass.md) | Gap-finding questions before any build prompt | Catches missing rules before they become bugs |
| 05 | [Glossary](practices/05-glossary.md) | One term per concept, with a synonym check | Keeps names consistent across agents |
| 06 | [Security gate](practices/06-security-gate.md) | One checklist for every feature, API and page | Closes the holes agents commonly leave |
| 07 | [Docs discipline](practices/07-docs-discipline.md) | README, CHANGELOG, manual and specs move with code | Docs stay true, users stay informed |
| 08 | [Design first](practices/08-design-first.md) | Mock, pick, lock, then build on one design system | Fewer UI rewrites, consistent look |
| 09 | [Multi-agent rules](practices/09-multi-agent-rules.md) | Worktrees, branches and safety rules for many agents | Agents stop breaking each other's work |
| 10 | [Tier-0 agent files](practices/10-tier0-agent-files.md) | Small AGENTS.md with pointers to full rules | Rules always fit in context |
| 11 | [What I skip](practices/11-what-i-skip.md) | Heavy patterns left out on purpose | Keeps process proportional to project size |
| 12 | [Branching and release](practices/12-branching-and-release.md) | Hotfixes to main, features to development, joint OK for prod | Safe, predictable releases |
| 13 | [Requirements and decisions](practices/13-requirements-and-decisions.md) | Lock requirements, log decisions, label every claim | Agents never invent features |

### Templates

Copy into your repo:

| File | Use |
|------|-----|
| [templates/HANDOVER.md](templates/HANDOVER.md) | Module spec |
| [templates/PIPELINE.md](templates/PIPELINE.md) | Agent queue and gates |
| [templates/GLOSSARY.md](templates/GLOSSARY.md) | Standard terms |
| [templates/DECISIONS.md](templates/DECISIONS.md) | Dated decision log |
| [templates/PR_TEMPLATE.md](templates/PR_TEMPLATE.md) | Security and docs checklist (save as `.github/pull_request_template.md`) |

### Skills

Reusable agent skills will live in [skills/](skills/).

## Core principles

- **Lock, then build.** Requirements, then spec, then code. Agents never invent features.
- **Architecture is the bottleneck, not the model.** Clear boundaries beat clever prompts.
- **Small blast radius.** One module, one spec, one branch per agent.
- **Contracts are shared code.** Client and server import the same schemas.
- **Gates, not hope.** Typecheck, lint, tests and security checks run before every merge.
- **Resumable by default.** Any fresh agent can continue from the last checkpoint.
- **Secure by default.** Every feature passes the same security gate.
- **Docs move with code.** Behavior changes and doc changes ship in the same PR.

## Benefits

- **Fewer rewrites.** Specs and locked designs mean the first build is close to right.
- **Consistent code across agents.** Shared rules, contracts and a glossary make ten agents write like one team.
- **Safe, resumable work.** Checkpoints, isolated branches and stop rules mean nothing gets lost or overwritten.
- **Fewer security holes.** One guard, one checklist and CI checks on every route.
- **Faster onboarding.** New people and new agents read the same short files and get productive quickly.

## How to adopt

You do not need everything on day one. Start small:

1. **Start from the template.** Use [agent-ready-template](https://github.com/abdurrakib0/agent-ready-template). It ships with AGENTS.md, SPEC.md, FOUNDATIONS.md, PIPELINE.md, a contracts folder and CI.
2. **Write one spec and one AGENTS.md.** Pick your next feature, fill in [HANDOVER.md](templates/HANDOVER.md), and keep AGENTS.md short ([practice 10](practices/10-tier0-agent-files.md)).
3. **Add one CI gate.** Typecheck, lint and tests on every push and PR. Block merges on failure.
4. **Add the security gate.** Drop in the [PR template](templates/PR_TEMPLATE.md) and the shared permission guard ([practice 06](practices/06-security-gate.md)).
5. **Grow as you need.** Add contracts, pipeline, glossary and multi-agent rules when the project or team gets bigger.

## Contributing

Contributions are very welcome. This is a living playbook and it gets better with real experience from other builders.

- **Pull requests:** new practices, better examples, fixes and clearer wording.
- **Issues:** questions, problems you hit, or a practice that did not work for you.
- **Suggestions or modifications:** open a [suggestion issue](.github/ISSUE_TEMPLATE/suggestion.md) and describe what you would change.

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a PR.

## Acknowledgements

Some ideas here were sharpened by a talk on agentic engineering. The rest come from shipping real projects with agents.

## License

[MIT](LICENSE). Copyright (c) 2026 Abdur Rakib.
