# Steps

Run these in order. They are the eight Assessment Areas on the website, so every report covers all eight. Each finding has a `kind`:

- `note` — context worth knowing (what the app is, how a flow works)
- `good` — something done well
- `risk` — a problem to fix before real users, payments or private data

| step | Label | What to look for |
|---|---|---|
| `map` | Application map | Framework, services, database, integrations, and major functional areas. Hosting, number of tables/routes/functions, where it was built (Lovable, Bolt, etc.). One `note`. Also fill in `architecture` (the box-and-arrow map in `templates/report.md`): one box per real part of the system, one arrow per call between them. |
| `journeys` | Customer journeys | Registration, core product actions, administration, and payment. Follow each end to end and write it as a chain: `/book → createBooking() → bookings table → Stripe Checkout → webhook`. Flag steps that can fail silently or let two users collide. |
| `data` | Information movement | How customer and company data enters, moves through, and leaves the application: forms and APIs in; tables, files and logs; emails, exports, analytics, AI and other outside services out. Flag personal data in logs, URLs or third-party calls. |
| `access` | Access and privacy | Authentication, authorization, credentials, permissions, and private information. Committed secrets, secret keys in client code, missing row-level security, unscoped queries, admin pages without role checks. |
| `payments` | Payment integrity | Whether pricing and transaction decisions are controlled and verified securely. Prices or totals sent from the browser, unverified webhooks, order state the client can change, charges that can run twice. If the app takes no payments, one `note` saying so. |
| `dependencies` | Technology health | Outdated, abandoned, conflicting, or unnecessarily risky dependencies. Mismatched versions, unused packages, packages with known problems. |
| `quality` | Quality safeguards | Tests, failure handling, documentation, and protection against regressions. Automated tests around sign-in, payments and core data changes; error handling on outside calls; CI; a README someone else could follow. |
| `history` | Maintenance signals | Development history, ongoing ownership, unstable changes, and abandoned work. Who commits, how often, how big the commits are, one-shot generation vs. steady work, reverted or half-finished features. |
