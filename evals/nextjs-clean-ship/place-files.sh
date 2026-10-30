#!/usr/bin/env bash
# Copies the app in and builds a steady history from two people. Each commit adds only its own files.
set -eu
SRC="$(dirname "$0")/files"
git init -q -b main
cp -R "$SRC/." .
c() { GIT_AUTHOR_NAME="$1" GIT_AUTHOR_EMAIL="$1@example.com" GIT_COMMITTER_NAME="$1" GIT_COMMITTER_EMAIL="$1@example.com" GIT_AUTHOR_DATE="$2" GIT_COMMITTER_DATE="$2" git commit -q -m "$3"; }
# First commit pins an older Next.js; the last commit bumps it.
sed -i.bak 's/"next": "\^15.5.4"/"next": "^15.5.0"/' package.json && rm package.json.bak
git add package.json package-lock.json .gitignore README.md .env.example tsconfig.json; c jdoe 2026-07-01T10:00:00 "Scaffold Next.js app"
git add prisma lib/db.ts; c jdoe 2026-07-03T10:00:00 "Add Prisma schema"
git add lib/auth.ts app/api/auth; c jdoe 2026-07-08T10:00:00 "Sign in with GitHub, users saved through the Prisma adapter"
git add lib/stripe.ts app/actions app/products app/orders; c asmith 2026-07-15T10:00:00 "Checkout prices from the database"
git add app/api/stripe; c asmith 2026-07-16T10:00:00 "Verify Stripe webhook signature"
git add tests vitest.config.ts; c jdoe 2026-07-22T10:00:00 "Tests for checkout and webhook"
git add .github; c asmith 2026-08-05T10:00:00 "Run tests in CI"
cp "$SRC/package.json" package.json
git add package.json; c jdoe 2026-10-20T10:00:00 "Bump next to 15.5.4"
test -z "$(git status --porcelain)" || { echo "place-files.sh: files left uncommitted" >&2; exit 1; }
