# Report output contract

Return **only** JSON in this shape. The website renders it directly.

```json
{
  "stack": "React + Vite, Supabase, Stripe",
  "verdict": "harden",
  "summary": "Two or three plain-language sentences: what works, what has to change before real users or payments, and how big the fixes are.",
  "findings": [
    {
      "step": "map",
      "kind": "note",
      "title": "React + Vite front end, Supabase back end, Stripe checkout",
      "detail": "4 tables, 3 Edge Functions, one Stripe webhook. Built in Lovable, synced to GitHub.",
      "files": ["package.json", "supabase/"],
      "evidence": "verified"
    },
    {
      "step": "access",
      "kind": "risk",
      "title": "Stripe secret key ships to the browser",
      "detail": "src/lib/stripe.ts reads VITE_STRIPE_SECRET_KEY, so the key is bundled into the front end.",
      "files": ["src/lib/stripe.ts:3"],
      "evidence": "verified",
      "fix": "Prompt for your agent: Move Stripe calls into a Supabase Edge Function and read the secret key there."
    }
  ],
  "unknowns": [
    "Row-level security policies set in the Supabase dashboard rather than in migrations"
  ],
  "architecture": {
    "groups": [{ "id": "supabase", "title": "SUPABASE — court-booker" }],
    "nodes": [
      { "id": "browser", "title": "Browser / PWA", "lines": ["React + Vite", "members (phone, desktop)"] },
      { "id": "app", "title": "src/ (Vite bundle)", "lines": ["React Router · 9 pages", "src/lib/stripe.ts", "reads VITE_STRIPE_SECRET_KEY"], "tone": "risk" },
      { "id": "auth", "title": "Supabase Auth", "group": "supabase", "lines": ["email + password"] },
      { "id": "db", "title": "Postgres", "group": "supabase", "lines": ["4 tables", "RLS on bookings only"], "tone": "risk" },
      { "id": "fns", "title": "Edge Functions", "group": "supabase", "lines": ["3 functions", "stripe-webhook"] },
      { "id": "stripe", "title": "Stripe", "lines": ["Checkout · webhook"] }
    ],
    "edges": [
      { "from": "browser", "to": "app", "label": "loads" },
      { "from": "app", "to": "auth", "label": "sign in" },
      { "from": "app", "to": "db", "label": "reads members table", "tone": "risk" },
      { "from": "app", "to": "stripe", "label": "Checkout with secret key", "tone": "risk" },
      { "from": "stripe", "to": "fns", "label": "webhook" },
      { "from": "fns", "to": "db", "label": "marks booking paid" }
    ]
  }
}
```

## Architecture map

`architecture` is a box-and-arrow map of the app as it exists in the repo. The website draws it. Build it during the `map` step and refine it as the journeys become clear.

- `nodes`: 3–10 boxes. Each is a real part of the system: the browser or client, the app or server code, the database, auth, background functions, and every outside service (payments, email, AI APIs). `title` is short. `lines` are 1–4 short facts about that box (framework, counts, the file that matters, a port). Use real names from the repo.
- `edges`: arrows between node ids. `label` says what moves or why (`"loads"`, `"webhook"`, `"reads members table"`). `from` must point at the box that starts the call.
- `groups`: optional. Boxes that live in one place (a container, a cloud project, a hosting account) share a `group` id. `title` names that place.
- `tone` on a node or an edge: `"risk"` marks where a `risk` finding lives, `"focus"` marks the piece a human must act on. Leave it out otherwise.
- Keep it honest: only boxes and arrows you can point to in the code. Something you can't confirm goes in `unknowns`, not on the map.

## Rules

- `stack` is a short list a non-developer would recognize.
- `verdict` is exactly one of `ship`, `harden`, `rebuild`, or `retire`. See `references/verdicts.md`.
- `step` is one of the ids in `references/steps.md`. Give every step at least one finding, in step order.
- `kind` is `note`, `good`, or `risk`.
- `files` holds repo paths, with `:line` when there is one. Never a secret's value.
- `evidence` is `verified` or `inferred`.
- `fix` is only on `risk` findings: one sentence the owner can paste into their AI agent, starting `Prompt for your agent:`.
- 8–16 findings. 2–5 unknowns.
- `architecture` is always present. See "Architecture map" above.
- Keep the keys and their names as shown. The website breaks on any other shape.
