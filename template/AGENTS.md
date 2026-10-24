# Agent Rules

Before writing any code, read in this order: `docs/BRIEF.md`, `docs/ARCHITECTURE.md`, `docs/FOUNDATIONS.md`, `docs/SPEC.md`, then `PIPELINE.md`.

## Scope
- Work only on the next unchecked item in `PIPELINE.md`.
- Build only what `docs/SPEC.md` describes. If something is missing or unclear, stop and add a question under "Open questions" in the spec. Do not guess.
- Do not change `contracts/` without updating the spec and noting it in the commit message.
- Never add a dependency, module or service without asking the owner first and adding an entry to `docs/DECISIONS.md`.

## Code
- Follow the conventions and module layout in `docs/FOUNDATIONS.md` exactly.
- Import other modules only through their `index`. No cross-module database joins.
- Keep changes small and focused on one pipeline item.

## Security
- Never read, print or edit `.env` files. Use `.env.example` for variable names.
- Never put secrets in code, logs or client-side variables.

## Tests and commits
- Every acceptance criterion you touch needs proof: a test or a quick check command.
- Run `./scripts/check.sh` before every commit. Never commit a failing check.
- One pipeline item per commit. Tick the item in `PIPELINE.md` in the same commit.
- Commit message: `<pipeline item id>: <what changed>`.

## Resuming
A new session starts by reading `PIPELINE.md` and `git log -10`, then continues from the first unchecked item.
