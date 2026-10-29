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
      "step": "security",
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
  ]
}
```

- `stack` is a short list a non-developer would recognize.
- `verdict` is one of the ids in `references/verdicts.md`.
- `step` is one of the ids in `references/steps.md`. Give every step at least one finding, in step order.
- `kind` is `note`, `good`, or `risk`.
- `files` holds repo paths, with `:line` when there is one. Never a secret's value.
- `evidence` is `verified` or `inferred`.
- `fix` is only on `risk` findings: one sentence the owner can paste into their AI agent, starting `Prompt for your agent:`.
- 6–14 findings. 2–5 unknowns.
- Keep the keys and their names as shown. The website breaks on any other shape.
