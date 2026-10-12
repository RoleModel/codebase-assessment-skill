# Steps

Run these in order. Each finding has a `kind`:

- `note` — context worth knowing (what the app is, how a flow works)
- `good` — something done well
- `risk` — a problem to fix before real users, payments or private data

| step | Label | What to look for |
|---|---|---|
| `map` | Map the app | Framework, hosting, database, number of tables/routes/functions, where it was built (Lovable, Bolt, etc.). One `note`. Also fill in `architecture` (the box-and-arrow map in `templates/report.md`): one box per real part of the system, one arrow per call between them. |
| `flows` | Trace user and data flows | Follow the main user flow end to end (sign-up, the core action, payment). Write it as a chain: `/book → createBooking() → bookings table → Stripe Checkout → webhook`. |
| `stack` | Check the stack | Outdated, abandoned or unused packages; mismatched versions; risky dependencies. |
| `security` | Credentials and security | Committed secrets, secret keys in client code, missing row-level security, unscoped queries, unverified webhooks, prices from the client. |
| `tests` | Tests and docs | Automated tests around sign-in, payments and core data changes; a README someone else could follow. |
| `history` | Read the git history | Who commits, how often, how big the commits are, signs of one-shot generation vs. steady work, reverted or abandoned work. |
