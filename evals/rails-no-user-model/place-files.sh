#!/usr/bin/env bash
# Copies the app in and builds a history where config/master.key was committed, then removed.
set -eu
SRC="$(dirname "$0")/files"
git init -q -b main
git config user.name "jdoe"; git config user.email "jdoe@example.com"
cp -R "$SRC/." .
c() { git add -A; GIT_AUTHOR_DATE="$1" GIT_COMMITTER_DATE="$1" git commit -q -m "$2"; }
c 2026-09-01T10:00:00 "Initial Replit Agent build"
echo "0f1e2d3c4b5a69788796a5b4c3d2e1f0" > config/master.key
c 2026-09-02T10:00:00 "Add credentials"
echo "# tweak" >> app/controllers/orders_controller.rb
c 2026-09-02T11:00:00 "Fix orders"
GIT_COMMITTER_DATE=2026-09-02T12:00:00 git revert --no-edit HEAD >/dev/null
git rm -q config/master.key && echo "/config/master.key" > .gitignore
c 2026-09-03T10:00:00 "Remove master key"
