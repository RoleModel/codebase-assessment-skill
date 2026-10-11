# Next.js

- Anything prefixed `NEXT_PUBLIC_` ships to the browser — no secrets there.
- Route handlers and server actions must check the session themselves; middleware alone isn't enough.
- Stripe webhooks need `stripe.webhooks.constructEvent` with the signing secret.
