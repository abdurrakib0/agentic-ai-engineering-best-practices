# Foundations

One source of truth for how code is written in this repo.

## Stack
- Language and version:
- Framework:
- Database:
- Hosting:

## Structure
Modular monolith: one app, one database, one folder per business module (see `docs/ARCHITECTURE.md`).
```
src/
  modules/
    <module>/
      index        the only file other modules may import
      routes       HTTP layer, matches contracts/
      service      plain functions, business rules live here
      db           queries for tables this module owns
      tests/
  shared/        config, logging, errors only
```
Rules:
- Other modules import only a module's `index`.
- Each module owns its tables. No cross-module joins or foreign keys into another module's tables. Call its `index` instead.
- `src/shared/` holds only config, logging and errors.

## Conventions
- Naming:
- Formatting and lint tool:
- Imports:

## Errors
- How errors are represented and returned:
- What gets logged:

## Testing
- Test tool:
- Every acceptance criterion in SPEC.md has proof: a test, or a quick check command written next to it.
- Test for confidence, not coverage. Test the risky parts well; skip tests that only repeat the code.
- Run all tests: `<command>`
- Run lint: `<command>`

## Dependencies
New dependencies need the owner's yes and an entry in `docs/DECISIONS.md`. Check the package exists, its downloads and its release age first.

| Package | Why |
|---|---|
