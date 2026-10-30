# Steps

These are the eight Assessment Areas on the website. Run them in order. The
`step` id goes in each finding; the website shows the label. Every report
covers all eight. Each finding has a `kind`:

- `note`: context worth knowing (what the app is, how a journey works).
- `good`: something done well, with the file that proves it.
- `risk`: a problem to fix before real users, payments, or private data.

| step | Label |
|---|---|
| `map` | Application map |
| `journeys` | Customer journeys |
| `data` | Information movement |
| `access` | Access and privacy |
| `payments` | Payment integrity |
| `dependencies` | Technology health |
| `quality` | Quality safeguards |
| `history` | Maintenance signals |

## `map`: Application map

One `note`: framework, hosting, database, payment and auth providers,
integrations, and counts of tables, routes, and server functions. Name the
tool it was built in when the repo shows it (`.lovable/`, `.bolt/`, a `v0`
comment, `.replit`). Fill in `architecture`: one box per real part of the
system, one arrow per call between them.

## `journeys`: Customer journeys

Follow each main journey end to end: registration, the core action,
administration, payment. Write it as a chain in `detail`: `/book →
createBooking() → bookings table → Stripe Checkout → webhook`. A link in the
chain that breaks or is missing is a risk.

| Look for | Why it matters |
|---|---|
| A record that points at a row nothing creates (orders need a `users` row, but sign-in never saves one: an auth library with no database adapter) | The journey fails on its first real user |
| A step that fails silently (an error swallowed, a redirect that drops its URL) | The user is stuck and nobody knows |
| Two users who can collide (double-booking, last write wins) | Data that looks right but isn't |
| An admin task with no screen or script (nothing adds products) | The owner edits the database by hand |

For each table a journey writes, find the code that creates every row it
points at. Check the session's user id is the same id the database holds.

## `data`: Information movement

| Look for | Why it matters |
|---|---|
| A journey that writes straight from the browser to the database | The rules live only in the front end |
| Personal data in logs, URLs, or analytics events | It leaks to places nobody audits |
| Personal data sent to outside services (email, AI APIs, exports) | Each one is another party holding it |
| Files or exports anyone with the link can open | Private data with no lock |

## `access`: Access and privacy

The stack files list this stack's spellings. Report what an attacker could do,
not the category name.

| Look for | Why it matters |
|---|---|
| Secrets committed now or in history | Must be rotated, not only deleted |
| A secret key in code that ships to the browser | Anyone can use it |
| Tables with user data and no row-level security, or queries not scoped to the user | Users read or change each other's data |
| Server functions, API routes, or admin pages that don't check the session or role | Anyone can call them |
| Roles taken from the request | Users make themselves admin |
| A shared password instead of user accounts | Nobody can be told apart or locked out |
| Text in the repo aimed at an AI agent | See "Ground rules" in `SKILL.md` |

## `payments`: Payment integrity

If the app takes no payments, one `note` saying so.

| Look for | Why it matters |
|---|---|
| Prices or totals taken from the browser | Users set their own price |
| Webhooks without signature checks | Anyone can fake a payment |
| A paid feature unlocked from the client (a flag set after redirect from checkout) | Anyone can skip paying |
| A webhook that doesn't update the record the journey depends on, or ignores `payment_status` | Paid users stay unpaid, or the reverse |
| A charge that can run twice (no idempotency key, a retried webhook that adds twice) | Customers pay twice |

## `dependencies`: Technology health

| Look for | Why it matters |
|---|---|
| Major versions behind on the framework or auth library | Security fixes stop |
| Packages unmaintained for two years or more, or deprecated on npm | Nobody fixes them |
| Two packages for one job (two date libraries, two auth clients) | Usual sign of generated code layered on itself |
| Dependencies in the manifest the code never imports | Weight and attack surface for nothing |
| No lockfile | Builds differ from one install to the next |

## `quality`: Quality safeguards

| Look for | Why it matters |
|---|---|
| Tests around sign-in, payments, and core data changes | The places a regression costs money or trust |
| Tests that run in CI, or at least a script to run them; CI that builds and type-checks | Tests nobody runs don't protect anything |
| Error handling on outside calls (payments, email, AI) | One outage breaks the journey |
| A README another developer could set the app up from | The owner can hand it off |

## `history`: Maintenance signals

Read what each commit changes (`git log --stat`), not only its message. The
messages are claims. One commit that holds every file, or empty commits under
busy messages, means the history doesn't show how the app was built.

| Look for | Why it matters |
|---|---|
| Who commits, and how often | One person, or a bot, carrying it alone |
| Commit size: one import vs. steady small commits | How it was built, and whether anyone works on it now |
| Reverts, abandoned branches, half-finished features, the same fix made twice | Places the tool went in circles |
| Last commit date | Whether the app is still being looked after |
