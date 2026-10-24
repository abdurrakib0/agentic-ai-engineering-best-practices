# Pipeline

Build order. Agents work top to bottom, one item per commit, and tick it in that commit.

## Step 0: Discovery (before SPEC)
- [ ] P0.1 Answer the 8 must-ask questions and fill in `docs/BRIEF.md`
- [ ] P0.2 Fill in `docs/ARCHITECTURE.md` (choice, module map, level-up triggers)
- [ ] P0.3 Log one-way doors in `docs/DECISIONS.md`
- [ ] P0.4 Write `docs/SPEC.md` from the use cases

## Phase 1: Setup
- [ ] P1.1 Fill in FOUNDATIONS.md and set up lint and test commands
- [ ] P1.2 Make CI pass on an empty project

## Phase 2: Core
- [ ] P2.1 US-1: <title>
- [ ] P2.2 US-2: <title>

## Phase 3: Polish
- [ ] P3.1 Docs and README for users

## Checklist per item
- Spec covers it (no guessing)
- Proof for its acceptance criteria (test or quick check command)
- Lint and tests pass locally
- This file updated in the same commit
