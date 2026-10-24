# 12. Branching and release

## Problem

Without clear rules, features and fixes land on the wrong branch, half-done work reaches production, and nobody is sure who approved a deploy.

## Practice

**Solo dev or a small team?** Use `main` plus short-lived branches, merge by PR when CI passes, and tag releases. The `development` branch and joint OK below are for teams with an owner and a lead dev.

- **Branches**
  - `main`: production. Always deployable.
  - `development`: integration branch for features.
  - `<name>/*`: personal or agent branches.
- **Features** open PRs into `development`.
- **Hotfixes** open PRs into `main`, then get merged back into `development`.
- **Production deploys** need a joint OK from the **owner and the lead dev**.
- Migrations deploy first (see [practice 09](09-multi-agent-rules.md)), then code.
- Tag every production release and add a CHANGELOG entry.

## Why

Agents produce many PRs quickly. Clear targets keep unfinished work out of production. A two-person release OK means product and engineering both agree it is ready.

## Benefit

- Production stays stable.
- Urgent fixes ship fast without waiting for feature work.
- Every release has a clear approver and a clear record.

## Example

```
agent-a/tasks-api  ->  development  ->  main (owner OK + lead dev OK)  ->  tag v1.4.0
hotfix/login-bug   ->  main (owner OK + lead dev OK)  ->  merge back to development
```

Protect branches: require PRs, passing gates and required reviewers on `main` and `development`.
