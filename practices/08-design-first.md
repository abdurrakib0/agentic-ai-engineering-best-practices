# 08. Design first

## Problem

Asking an agent to "build the page" gives a random design. The owner dislikes it, the agent rebuilds it, and each page ends up looking different.

## Practice

- **Mock first.** Generate 2 or 3 UI options (static mockups or quick prototypes).
- **Owner picks.** The owner chooses one, with notes.
- **Lock it.** Save the chosen design in the repo (for example `docs/<module>/design/`) and log the lock in DECISIONS.md.
- **Then build.** Only now does a coding agent implement it, against the locked design.
- **One reusable component per pattern.** One table, one form field, one modal, one empty state. No copies.
- **One design system,** applied consistently: tokens for color, spacing and type, used everywhere.
- **Tables are responsive and full width** by default, with horizontal scroll or stacked rows on small screens.

## Why

Design choices are cheap in a mockup and expensive in code. A locked design gives the agent a clear target. Shared components mean the agent reuses instead of reinventing.

## Benefit

- Fewer UI rewrites.
- A consistent look across every page.
- Faster builds, since most UI is assembled from existing parts.

## Example

```
docs/tasks/design/
  options/        # A.png, B.png, C.png
  locked.png      # the chosen one
  notes.md        # owner notes, date locked
src/components/ui/
  DataTable.tsx   # the only table component
  FormField.tsx
  Modal.tsx
  EmptyState.tsx
```
