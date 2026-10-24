# Contributing

Thanks for helping improve this playbook. PRs, issues and suggestions are all welcome.

## Ways to contribute

- **Suggest a change:** open an issue with the [suggestion template](.github/ISSUE_TEMPLATE/suggestion.md).
- **Fix or improve:** typos, clearer wording, better examples. Open a PR directly.
- **Propose a new practice:** open a PR with a new file in `practices/`.

## How to propose a practice

Every practice file follows the same shape:

1. **Problem:** what goes wrong without it. Be concrete.
2. **Practice:** the rule, in short bullets.
3. **Why:** why this works, especially with AI agents.
4. **Benefit:** what the team gets.
5. **Example:** a template, snippet or checklist someone can copy.

Name it `practices/NN-short-name.md` using the next free number, and add a row to the table of contents in README.md.

## Writing rules

- Plain English. Short sentences. Bullets over paragraphs.
- **No em dashes or en dashes.** Use a period, comma, colon or parentheses instead. Check before you push:
  ```bash
  grep -rn $'\u2014\|\u2013' . --include=*.md
  ```
- Keep it generic. No company names, private code, internal URLs or personal data.
- Prefer things people can copy: templates, checklists, small code samples.

## PR checklist

- [ ] The practice has Problem, Practice, Why, Benefit and Example sections
- [ ] README table of contents updated
- [ ] No em or en dashes (grep above returns nothing)
- [ ] No private or company-specific details
- [ ] Links work

## Code of conduct

Be kind, be specific, assume good intent.
