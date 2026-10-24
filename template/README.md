# Agent-Ready Repo Template

A starter for projects built with AI coding agents, from [Agentic AI Engineering Best Practices](https://github.com/abdurrakib0/agentic-ai-engineering-best-practices). The guide explains the why behind every file. Do a short discovery first, write the spec, give agents shared rules, and let CI gate every commit.

## How to use
1. Copy this folder into a new project (no git history):
   `npx degit abdurrakib0/agentic-ai-engineering-best-practices/template my-app`, then `cd my-app && git init`.
   Replace this README with your project's own once you start.
2. Fill in `docs/BRIEF.md` (answer the 8 must-ask questions: problem, users, use cases, appetite).
3. Fill in `docs/ARCHITECTURE.md` (modular monolith by default, module map, level-up triggers).
4. Log hard-to-undo choices in `docs/DECISIONS.md`.
5. Fill in `docs/FOUNDATIONS.md` (stack, conventions, errors, tests).
6. Fill in `docs/SPEC.md` (what you are building and how you'll know it's done).
7. Break the work into steps in `PIPELINE.md`.
8. If the project has an API, define it in `contracts/` before writing code.
9. Point your agent at `AGENTS.md` and start with the first unchecked item.

Reading order for agents: BRIEF, ARCHITECTURE, FOUNDATIONS, SPEC, then PIPELINE.

## Files
| File | Purpose |
|---|---|
| `AGENTS.md` | Rules every agent session follows. `CLAUDE.md` points here. |
| `docs/BRIEF.md` | Day 0 brief: problem, user and job, use cases, success number, appetite, out of scope, future direction. |
| `docs/ARCHITECTURE.md` | One page: architecture choice, context sketch, module map, outside systems, numbers, level-up triggers. |
| `docs/DECISIONS.md` | One-way door decisions only. |
| `docs/FOUNDATIONS.md` | Stack, module layout, conventions, error handling, testing rules. |
| `docs/SPEC.md` | Goal, user stories, acceptance criteria, out of scope. |
| `PIPELINE.md` | Build order and checklist, starting with Step 0 Discovery. Agents tick items as they commit. |
| `contracts/` | API contracts (OpenAPI or typed), written before code. |
| `SECURITY.md` | How to report a vulnerability privately. |
| `.env.example` | Variable names only. Copy to `.env`, which is git-ignored. |
| `.github/workflows/ci.yml` | Runs `scripts/check.sh` (lint, test, AGENTS.md size) on every push and pull request. |
| `.github/workflows/security.yml` | Secret scan on every push; dependency review on pull requests. |
| `.github/dependabot.yml` | Weekly dependency updates with a 5 day cooldown. Set the ecosystem for your stack. |

## Principles
- Ask before you build. Brief and architecture before spec, spec before code.
- Modular monolith by default. Split only when a written trigger fires.
- Log only one-way doors. Everything else is decided fast.
- Agents never build beyond the spec. Gaps go back into the spec.
- Small changes, small blast radius.
- Secrets stay out of git and out of the agent's reach.
- Every commit is a checkpoint: checks pass, `PIPELINE.md` updated, so a fresh agent can resume from git alone.

## After you push your repo to GitHub
In Settings, turn on private vulnerability reporting and Dependabot security updates. The template ships the files; these switches are per repo.

## License
MIT
