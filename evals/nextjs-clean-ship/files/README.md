# Order Desk

Customers order widgets and pay with Stripe. Built with Next.js, Prisma (Postgres), Auth.js, and Stripe.

## Setup

1. `cp .env.example .env` and fill in the values.
2. `npm ci`
3. `npx prisma migrate dev`
4. `npm run dev`

## Stripe webhooks locally

`stripe listen --forward-to localhost:3000/api/stripe/webhook`, then put the printed `whsec_` value in `STRIPE_WEBHOOK_SECRET`.

## Tests

`npm test` runs the Vitest suite. CI runs it on every push.
