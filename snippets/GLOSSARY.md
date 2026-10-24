# GLOSSARY

> One standard term per concept. Use it in specs, code, UI and docs.
> `npm run check:glossary` warns when a banned synonym appears.

| Term | Meaning | Use in code | Do not use |
|------|---------|-------------|------------|
| Member | A person with an account in a workspace | `member`, `Member` | user, account, person |
| Workspace | The top-level container that owns data | `workspace` | org, team, tenant |
| Task | A unit of work assigned to a member | `task` | ticket, todo, job |
| Assignee | The member a task is assigned to | `assigneeId` | owner, worker |

## Rules

- Add a new term here before using it anywhere.
- One concept, one term. If two terms mean the same thing, pick one and ban the other.
- Code names match the glossary term (camelCase or PascalCase as needed).
