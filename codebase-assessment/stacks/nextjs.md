# Next.js

Loaded when `package.json` names `next`.

## Security sinks

- Anything prefixed `NEXT_PUBLIC_` ships to the browser. No secrets there.
- Files with `'use client'`, and every module they import, ship to the
  browser. An unprefixed env var read there is `undefined`, not leaked. AI
  tools often "fix" that by adding `NEXT_PUBLIC_` to a secret; check the
  history of `.env*` and `next.config.*` for that rename.
- Route handlers (`app/**/route.ts`) and server actions (`'use server'`) must
  check the session themselves. `middleware.ts` alone isn't enough: its
  `matcher` often misses routes, and server actions can be called directly.
- Stripe webhooks need `stripe.webhooks.constructEvent` with the raw body and
  the signing secret.

## Unknowns to list

Env vars set in the Vercel dashboard, and whether preview deployments are
protected.
