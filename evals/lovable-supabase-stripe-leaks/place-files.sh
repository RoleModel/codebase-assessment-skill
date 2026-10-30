#!/usr/bin/env bash
# Copies the app in and builds its git history: one Lovable import, then two small edits.
set -eu
SRC="$(dirname "$0")/files"
git init -q -b main
git config user.name "gpt-engineer-app[bot]"; git config user.email "bot@example.com"
cp -R "$SRC/." .
git rm -q --cached -r . >/dev/null 2>&1 || true
git add -A && GIT_AUTHOR_DATE="2026-08-01T10:00:00" GIT_COMMITTER_DATE="2026-08-01T10:00:00" git commit -q -m "Initial commit from Lovable"
git config user.name "jdoe"; git config user.email "jdoe@example.com"
echo "" >> README.md
git add -A && GIT_AUTHOR_DATE="2026-08-02T09:00:00" GIT_COMMITTER_DATE="2026-08-02T09:00:00" git commit -q -m "Update README"
echo "// add success page" >> src/pages/Success.tsx
git add -A && GIT_AUTHOR_DATE="2026-08-02T09:30:00" GIT_COMMITTER_DATE="2026-08-02T09:30:00" git commit -q -m "Mark booking paid on success page"
