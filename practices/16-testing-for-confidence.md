# 16. Testing for confidence

## Problem

Agents can write hundreds of tests in minutes. Many test the implementation instead of behavior, lock in existing bugs, break on every refactor and bury reviewers. Some agents also "fix" a failing gate by deleting or disabling tests.

## Practice

- **Test as little as needed to be confident.** Test behavior that matters: money, permissions, data loss, core flows and bugs you already fixed once.
- **One meaningful test per change** is usually enough. It must fail if the change is reverted.
- **No mass-generated test suites.** Do not ask the agent to "add tests for everything" or to write tests from existing code.
- **Write the test from the requirement,** not from the code, so it checks what should happen.
- **Hard rule:** the agent never deletes, skips or disables a test, and never adds features nobody asked for. If a test seems wrong, it stops and asks.

## Why

Tests are there to give confidence, not coverage numbers. A small set of sharp tests catches real breakage and stays cheap to run and review.

## Benefit

- Faster CI and faster reviews.
- Fewer brittle tests to maintain.
- Gates you can trust, because nobody quietly weakens them.

## Example

Add this to AGENTS.md:

```markdown
## Never
- delete, skip or disable a test to make a gate pass
- add features, options or files that were not asked for
```

## Sources

- Kent Beck: "I get paid for code that works, not for tests, so my philosophy is to test as little as possible to reach a given level of confidence": https://stackoverflow.com/questions/153234/how-deep-are-your-unit-tests/153565
- Kent Beck, warning sign: the AI "cheating, for example by disabling or deleting tests": https://tidyfirst.substack.com/p/augmented-coding-beyond-the-vibes
- Simon Willison, one test that fails if the change is reverted: https://simonwillison.net/2025/Dec/18/code-proven-to-work/
- Reddit r/ExperiencedDevs, huge AI test suites are a review burden: https://www.reddit.com/r/ExperiencedDevs/comments/1po8uud/my_teammates_are_generating_enormous_test_suites/
- Reddit r/ExperiencedDevs, AI tests written from code lock in bugs: https://www.reddit.com/r/ExperiencedDevs/comments/1iphntb/ai_generated_unit_tests_documentation_for_a/
