#!/usr/bin/env bash
# Edit the lint and test commands to match docs/FOUNDATIONS.md. CI runs this file.
set -euo pipefail

# Keep AGENTS.md short so agents read all of it.
size=$(wc -c < AGENTS.md)
if [ "$size" -gt 4096 ]; then
  echo "AGENTS.md is $size bytes. Keep it under 4 KB."
  exit 1
fi

echo "lint: replace with your lint command"
echo "test: replace with your test command"
