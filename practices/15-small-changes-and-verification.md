# 15. Small changes and verification

## Problem

Agents produce big diffs that look right and are hard to review. Without a way to check their own work, they stop at "plausible" instead of "working".

## Practice

- **One logical change at a time.** Each task, commit and PR does one thing you can review in minutes.
- **Give a goal and a check, not step-by-step orders.** For example: "make this failing test pass" or "the page shows the new field and the build passes".
- **Naive first, then optimize.** Ask for the simple, obviously correct version first. Optimize later while keeping the same checks green.
- **The agent must prove it works.** Every change comes with proof: one manual check (run it, click it, curl it) plus one automated test that would fail if the change were reverted.
- **Give the agent eyes.** A command to start the server, run the tests or see the UI, so it can verify by itself.
- **Commit after every working step,** so you can always roll back.

## Why

Small changes keep the blast radius small and make review possible. A clear check lets the agent loop until the work is actually done, instead of until it looks done.

## Benefit

- Faster, easier reviews.
- Easy reverts when something goes wrong.
- Much higher quality on the first try.

## Example

```text
Goal: add a due date filter to GET /api/tasks.
Done when: npm test passes, and curl "/api/tasks?due=2026-01-10" returns only matching tasks.
Add one test that fails without this change. Do not touch unrelated files.
```

## Sources

- Karpathy, AI coding rhythm: one concrete incremental change, test, git commit, a "very tight leash": https://x.com/karpathy/status/1915581920022585597
- Karpathy, give success criteria, naive version first then optimize: https://x.com/karpathy/status/2015883857489522876
- Linux kernel: "Separate each logical change into a separate patch.": https://www.kernel.org/doc/html/latest/process/submitting-patches.html
- Boris Cherny: a way to verify its work will "2-3x the quality of the final result": https://x.com/bcherny/status/2007179861115511237
- Boris Cherny, give the agent a way to see the output: https://x.com/bcherny/status/2007202802154745888
- Simon Willison, ship code proven to work: https://simonwillison.net/2025/Dec/18/code-proven-to-work/
