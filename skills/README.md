# Skills

A skill is a short Markdown file (`SKILL.md`) that teaches an agent one repeatable task. The agent loads it only when the task needs it, so it costs no context the rest of the time.

## Copied skills

These four are copied unchanged into [third_party/](third_party/), each with its original MIT LICENSE file. Copy a folder into your agent's skills directory (for Claude Code: `.claude/skills/<name>/`).

| Skill | What it does | Why it is useful | Source | License |
|-------|--------------|------------------|--------|---------|
| [git-guardrails-claude-code](third_party/git-guardrails-claude-code/) | Sets up a hook that blocks `git push`, `reset --hard`, `clean -f`, `branch -D` and `checkout .` | Hard git safety rules hold every time ([practice 18](../practices/18-hooks-for-must-always-rules.md)) | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT |
| [handoff](third_party/handoff/) | Compacts the current session into a handoff doc for a fresh agent | Clean resume without carrying a long chat ([practice 03](../practices/03-pipeline.md)) | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT |
| [verification-before-completion](third_party/verification-before-completion/) | No "done" or "fixed" claim without fresh command output as proof | Stops false success reports ([practice 15](../practices/15-small-changes-and-verification.md)) | [obra/superpowers](https://github.com/obra/superpowers) | MIT |
| [systematic-debugging](third_party/systematic-debugging/) | Find the root cause before proposing any fix | No symptom patches or guess-and-check loops | [obra/superpowers](https://github.com/obra/superpowers) | MIT |

Testing stance stays the same as [practice 16](../practices/16-testing-for-confidence.md): proof is one command output or a quick manual check. These skills do not mean adding new test suites. Where a copied skill asks for test output, use the one check that proves your change.

## Link-only skills

Useful, but not copied. Read and install from the source if you need them.

| Skill | What it does | When to use | Source | License |
|-------|--------------|-------------|--------|---------|
| requesting-code-review | Sends the diff to a reviewer subagent with crafted context | Big or risky changes ([practice 19](../practices/19-fresh-eyes-review.md)) | [obra/superpowers](https://github.com/obra/superpowers) | MIT |
| prototype | Throwaway prototype to answer one design question, no tests, no polish | Before committing to an approach | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT |
| diagnosing-bugs | Build a tight pass/fail feedback loop first, then debug | Alternative to systematic-debugging | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT |
| webapp-testing | Playwright screenshots and browser logs to check UI work | UI changes only | [anthropics/skills](https://github.com/anthropics/skills) | Apache-2.0 |
| frontend-design | Distinctive UI instead of templated defaults | Design work ([practice 08](../practices/08-design-first.md)) | [anthropics/skills](https://github.com/anthropics/skills) | Apache-2.0 |
| skill-creator | Writes and tests new skills | When you write your own skill | [anthropics/skills](https://github.com/anthropics/skills) | Apache-2.0 |
| differential-review | Security-focused review of a diff: auth, money, blast radius | Sensitive diffs ([practice 06](../practices/06-security-gate.md)) | [trailofbits/skills](https://github.com/trailofbits/skills) | CC-BY-SA-4.0 (share-alike, not copied) |

## Format for new skills

One folder per skill:

```
skills/
  <skill-name>/
    SKILL.md      # when to use it, steps, done criteria
    examples/     # optional input and output samples
```

Third-party skills go in `third_party/<skill-name>/` with their original LICENSE file. Copy only MIT or Apache-2.0 skills.
