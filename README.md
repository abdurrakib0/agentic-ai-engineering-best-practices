# Agentic AI Engineering Best Practices

**Practical rules, templates and checklists for building real software with AI coding agents.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Last commit](https://img.shields.io/github/last-commit/abdurrakib0/agentic-ai-engineering-best-practices)](https://github.com/abdurrakib0/agentic-ai-engineering-best-practices/commits/main)

Maintained by Abdur Rakib ([@abdurrakib0](https://github.com/abdurrakib0)).

---

## Start a new project

The [template/](template/) folder is a ready starter: AGENTS.md, docs (BRIEF, ARCHITECTURE, SPEC, FOUNDATIONS, DECISIONS), PIPELINE.md, contracts, SECURITY.md, `.env.example` and CI with a security workflow.

Copy it into a new folder (no git history, no guide files):

```bash
npx degit abdurrakib0/agentic-ai-engineering-best-practices/template my-app
cd my-app && git init
```

No Node? Use plain git:

```bash
git clone --depth 1 https://github.com/abdurrakib0/agentic-ai-engineering-best-practices.git
mkdir my-app && cp -r agentic-ai-engineering-best-practices/template/. my-app/
cd my-app && git init
```

Then:

1. Fill in `docs/BRIEF.md` first.
2. Tell your agent: "Read AGENTS.md and start with the first unchecked item in PIPELINE.md."

More steps are in [template/README.md](template/README.md).

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
| 06 | [Security gate](practices/06-security-gate.md) | One guard and one checklist; heavy tests on sensitive routes | Closes the holes agents commonly leave |
| 07 | [Docs discipline](practices/07-docs-discipline.md) | README, CHANGELOG and specs move with code; CHANGELOG drives user updates | Docs stay true, users stay informed |
| 08 | [Design first](practices/08-design-first.md) | Mock, pick, lock, then build on one design system | Fewer UI rewrites, consistent look |
| 09 | [Multi-agent rules](practices/09-multi-agent-rules.md) | Worktrees, branches and safety rules for many agents | Agents stop breaking each other's work |
| 10 | [Tier-0 agent files](practices/10-tier0-agent-files.md) | Small AGENTS.md with pointers to full rules | Rules always fit in context |
| 11 | [What I skip](practices/11-what-i-skip.md) | Heavy patterns left out on purpose | Keeps process proportional to project size |
| 12 | [Branching and release](practices/12-branching-and-release.md) | Hotfixes to main, features to development, joint OK for prod | Safe, predictable releases |
| 13 | [Requirements and decisions](practices/13-requirements-and-decisions.md) | Lock requirements, log decisions, label claims on big specs | Agents never invent features |
| 14 | [Simplicity first](practices/14-simplicity-first.md) | Dumbest thing that works, YAGNI, delete code, boring tech, few deps | Smaller code that agents and people can read |
| 15 | [Small changes and verification](practices/15-small-changes-and-verification.md) | One logical change, goal plus a check, proof it works | Easy reviews, higher first-try quality |
| 16 | [Testing for confidence](practices/16-testing-for-confidence.md) | Few sharp tests, no mass-generated suites, never weaken tests | Fast CI you can trust |
| 17 | [Review every diff](practices/17-review-every-diff.md) | Read diffs, spot warning signs, turn repeat mistakes into one rule | Silent damage caught, mistakes not repeated |
| 18 | [Hooks for must-always rules](practices/18-hooks-for-must-always-rules.md) | Format after edits and block dangerous git with hooks | Hard rules hold every time |
| 19 | [Fresh-eyes review](practices/19-fresh-eyes-review.md) | Clean-context reviewer for auth, money and migrations; correctness gaps only | Serious bugs caught without review noise |
| 20 | [Parallel agents](practices/20-parallel-agents.md) | Start with 2 or 3, own worktree, port and DB, short task list | More done without a review backlog |
| 21 | [Model routing](practices/21-model-routing.md) | Top model plans and debugs, mid model codes, small model searches | Lower cost, quality where it matters |
| 22 | [Overnight runs](practices/22-overnight-runs.md) | Goal plus check, one task per commit, progress.md, caps and one notify hook | Safe unattended work with a clear morning review |
| 23 | [Agent safety](practices/23-agent-safety.md) | Avoid the lethal trifecta, sandbox and scoped test credentials | Secrets stay safe, mistakes stay small |
| 24 | [Day 0 discovery and architecture](practices/24-day0-discovery-and-architecture.md) | 8 must-ask questions, one-page brief, module map, modular monolith by default, log one-way doors | Expensive mistakes caught before code; agents follow one structure |
| 25 | [Security baseline](practices/25-security-baseline.md) | 10 must-haves: secret scanning, keys away from agents, delayed deps, one free scanner, rate limits, least privilege | Closes the common leaks in agent-built apps in about half a day |

### Guides

| Guide | What |
|-------|------|
| [Tips and tricks](practices/tips-and-tricks.md) | Short habits for planning, prompting, checkpoints and review |
| [Token efficiency](practices/token-efficiency.md) | Fresh sessions, short agent files, no log dumps, right-sized models |

### Snippets

Single files (in [snippets/](snippets/)) to copy into an existing repo. Starting a new project? Use the full [template/](template/) starter kit instead.

| File | Use |
|------|-----|
| [snippets/HANDOVER.md](snippets/HANDOVER.md) | Module spec |
| [snippets/PIPELINE.md](snippets/PIPELINE.md) | Agent queue and gates |
| [snippets/GLOSSARY.md](snippets/GLOSSARY.md) | Standard terms |
| [snippets/DECISIONS.md](snippets/DECISIONS.md) | Dated decision log, one-way doors only |
| [snippets/PR_TEMPLATE.md](snippets/PR_TEMPLATE.md) | Security and docs checklist (save as `.github/pull_request_template.md`) |

### Skills

Five core skills (git guardrails, handoff, verification before completion, systematic debugging, domain modeling) are copied with their MIT licenses into [skills/third_party/](skills/third_party/). [skills/README.md](skills/README.md) lists them plus link-only skills worth knowing.

## Core principles

- **Lock, then build.** Requirements, then spec, then code. Agents never invent features.
- **Architecture is the bottleneck, not the model.** Clear boundaries beat clever prompts.
- **Small blast radius.** One module, one spec, one branch per agent.
- **Contracts are shared code.** Client and server import the same schemas.
- **Gates, not hope.** Typecheck, lint, tests and the authz check run before every merge. Extra gates only when needed.
- **Resumable by default.** Any fresh agent can continue from the last checkpoint.
- **Secure by default.** Every feature passes the same security gate.
- **Docs move with code.** Behavior changes and doc changes ship in the same PR.
- **Simplest thing that works.** No abstractions, options or dependencies before they are needed. Delete freely.
- **Small and proven.** One logical change at a time, with proof that it works.
- **Tests for confidence, not coverage.** Few sharp tests. Agents never weaken tests or add unrequested features.
- **Read every diff.** Turn each repeated agent mistake into one short rule or check.
- **Lean context.** Fresh session per task, short agent files, no log dumps.
- **Hooks for hard rules.** If a rule must never be skipped, a hook enforces it, not a line of advice.
- **Right model for the job.** Top model for plans and hard bugs, cheaper models for routine work and search.
- **Parallel only as fast as you review.** Start with 2 or 3 agents, each fully isolated.
- **Unattended means capped.** Sandbox, branch, test credentials, turn and budget limits.
- **Ask before you build.** A short Day 0 discovery, a modular monolith by default, and a written trigger before any split.
- **Log only one-way doors.** Hard-to-undo choices get a decision entry; everything else is decided fast.
- **Baseline security, not security theater.** Ten cheap must-haves that run on their own; extras only when the feature exists.

## Benefits

- **Fewer rewrites.** Specs and locked designs mean the first build is close to right.
- **Consistent code across agents.** Shared rules, contracts and a glossary make ten agents write like one team.
- **Safe, resumable work.** Checkpoints, isolated branches and stop rules mean nothing gets lost or overwritten.
- **Fewer security holes.** One guard, one checklist and CI checks on every route.
- **Faster onboarding.** New people and new agents read the same short files and get productive quickly.
- **Less code to maintain.** Simple code, few dependencies and regular deletion keep the codebase small.
- **Faster reviews and CI.** Small diffs and a few meaningful tests instead of giant PRs and test suites.
- **Lower token cost.** Short context means faster, cheaper and more focused agent sessions.
- **Rules that always hold.** Hooks format code and block dangerous commands every time.
- **Work while you sleep.** Overnight runs with caps and a morning report, without surprise bills.
- **Safer agents.** No leaked secrets from prompt injection, and mistakes stay inside the sandbox.
- **Right structure from Day 0.** A clear brief and module map before code, without microservices or heavy layers.

## How to adopt

You do not need everything on day one. Start small:

1. **Start from the template.** Copy the [template/](template/) folder (see [Start a new project](#start-a-new-project)). It ships with AGENTS.md, BRIEF.md, ARCHITECTURE.md, SPEC.md, FOUNDATIONS.md, DECISIONS.md, PIPELINE.md, a contracts folder, SECURITY.md and CI with a security workflow.
2. **Run Day 0 discovery.** Answer the 8 must-ask questions and write a one-page brief and module map ([practice 24](practices/24-day0-discovery-and-architecture.md)).
3. **Write one spec and one AGENTS.md.** Pick your next feature, fill in [HANDOVER.md](snippets/HANDOVER.md), and keep AGENTS.md short ([practice 10](practices/10-tier0-agent-files.md)).
4. **Add one CI gate.** Typecheck, lint and tests on every push and PR. Block merges on failure.
5. **Add the security gate and baseline.** Drop in the [PR template](snippets/PR_TEMPLATE.md), the shared permission guard ([practice 06](practices/06-security-gate.md)) and the 10 must-haves ([practice 25](practices/25-security-baseline.md)).
6. **Grow as you need.** Add contracts, pipeline, glossary and multi-agent rules when the project or team gets bigger.

## Contributing

Contributions are very welcome. This is a living playbook and it gets better with real experience from other builders.

- **Pull requests:** new practices, better examples, fixes and clearer wording.
- **Issues:** questions, problems you hit, or a practice that did not work for you.
- **Suggestions or modifications:** open a [suggestion issue](.github/ISSUE_TEMPLATE/suggestion.md) and describe what you would change.

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a PR.

## Acknowledgements

Some ideas here were sharpened by a talk on agentic engineering. The rest come from shipping real projects with agents.

## Credits and further reading

Practices 14 to 23, the guides and the skills list draw on public writing by these engineers. Quotes in the practice files are copied from the linked sources.

- Andrej Karpathy: [vibe coding](https://x.com/karpathy/status/1886192184808149383), [AI coding rhythm](https://x.com/karpathy/status/1915581920022585597), [workflows](https://x.com/karpathy/status/1959703967694545296), [notes on agent coding](https://x.com/karpathy/status/2015883857489522876), [new conversation per request](https://x.com/karpathy/status/1902737525900525657), [nanochat](https://github.com/karpathy/nanochat)
- Boris Cherny (creator of Claude Code): [his setup](https://x.com/bcherny/status/2007179832300581177), [verify your work](https://x.com/bcherny/status/2007179861115511237), [setup summary on Reddit](https://www.reddit.com/r/ClaudeAI/comments/1q2c0ne/claude_code_creator_boris_shares_his_setup_with/)
- Simon Willison: [Using LLMs for code](https://simonwillison.net/2025/Mar/11/using-llms-for-code/), [Code proven to work](https://simonwillison.net/2025/Dec/18/code-proven-to-work/), [The lethal trifecta](https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/), [Designing agentic loops](https://simonwillison.net/2025/Sep/30/designing-agentic-loops/), [Parallel coding agents](https://simonwillison.net/2025/Oct/5/parallel-coding-agents/)
- Armin Ronacher: [Agentic coding recommendations](https://lucumr.pocoo.org/2025/6/12/agentic-coding/)
- Mitchell Hashimoto: [My AI adoption journey](https://mitchellh.com/writing/my-ai-adoption-journey)
- Kent Beck: [How deep are your unit tests](https://stackoverflow.com/questions/153234/how-deep-are-your-unit-tests/153565), [Augmented coding: beyond the vibes](https://tidyfirst.substack.com/p/augmented-coding-beyond-the-vibes)
- Martin Fowler: [YAGNI](https://martinfowler.com/bliki/Yagni.html)
- [Choose Boring Technology](https://boringtechnology.club/)
- Linux kernel: [Submitting patches](https://www.kernel.org/doc/html/latest/process/submitting-patches.html)
- Claude Code docs: [Best practices](https://code.claude.com/docs/en/best-practices), [Manage costs](https://code.claude.com/docs/en/costs), [Hooks](https://code.claude.com/docs/en/hooks-guide), [Model config](https://code.claude.com/docs/en/model-config), [CLI reference](https://code.claude.com/docs/en/cli-reference), [Sandboxing](https://code.claude.com/docs/en/sandboxing)
- Anthropic: [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents), [Choosing a model](https://platform.claude.com/docs/en/about-claude/models/choosing-a-model), [Prompting best practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)
- OpenAI: [Harness engineering](https://openai.com/index/harness-engineering/), [Codex models](https://developers.openai.com/codex/models), [Codex non-interactive mode](https://developers.openai.com/codex/noninteractive)
- HumanLayer: [Advanced context engineering](https://www.humanlayer.com/blog/advanced-context-engineering)
- Skills: [mattpocock/skills](https://github.com/mattpocock/skills) (MIT), [obra/superpowers](https://github.com/obra/superpowers) (MIT), [anthropics/skills](https://github.com/anthropics/skills), [trailofbits/skills](https://github.com/trailofbits/skills)
- Day 0 and architecture: [Shape Up](https://basecamp.com/shapeup/1.2-chapter-03), [Amazon 2015 letter (one-way and two-way doors)](https://s2.q4cdn.com/299287126/files/doc_financials/annual/2015-Letter-to-Shareholders.PDF), [Martin Fowler, MonolithFirst](https://martinfowler.com/bliki/MonolithFirst.html), [Shopify, deconstructing the monolith](https://shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity), [Jimmy Bogard, vertical slices](https://www.jimmybogard.com/vertical-slice-architecture/), [Microsoft, architect role](https://learn.microsoft.com/en-us/azure/well-architected/architect-role/design-business-requirements), [C4 model](https://c4model.com/)
- Security: [OWASP Top 10 (2025)](https://owasp.org/Top10/2025/), [OWASP Top 10 for LLM apps](https://genai.owasp.org/llm-top-10/), [OWASP cheat sheets](https://cheatsheetseries.owasp.org/), [GitHub secure use of Actions](https://docs.github.com/en/actions/reference/security/secure-use), [gitleaks](https://github.com/gitleaks/gitleaks), [Socket on slopsquatting](https://socket.dev/blog/slopsquatting-how-ai-hallucinations-are-fueling-a-new-class-of-supply-chain-attacks), [Microsoft on securing agentic CI/CD](https://www.microsoft.com/en-us/security/blog/2026/06/05/securing-ci-cd-in-agentic-world-claude-code-github-action-case/), [CSA Comment and Control](https://labs.cloudsecurityalliance.org/research/csa-research-note-comment-control-github-prompt-injection-20/)
- Reddit r/ExperiencedDevs threads on [overengineering](https://www.reddit.com/r/ExperiencedDevs/comments/1u1tgjq/the_biggest_problem_with_ai_is_not_correctness_it/) and [AI-generated test suites](https://www.reddit.com/r/ExperiencedDevs/comments/1po8uud/my_teammates_are_generating_enormous_test_suites/)

## License

[MIT](LICENSE). Copyright (c) 2026 Abdur Rakib.
