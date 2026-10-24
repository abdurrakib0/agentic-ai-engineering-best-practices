# Decisions

Log only **one-way doors**: choices that are hard or costly to undo (database, auth, tenancy, hosting, major vendor, public API shape, new dependency, module or service). Two-way doors are just decided, no entry.

A locked entry changes only with a new dated entry approved by the owner.

## Entry format

```
### D-00N: <title> (YYYY-MM-DD)
Door: one-way (why it is hard to undo)
Context: what we know, what we assume
Options: A ..., B ...
Decision: A, because ...
Locked by: owner
```

## Entries

### D-001: <title> (YYYY-MM-DD)
Door: one-way
Context:
Options:
Decision:
Locked by:
