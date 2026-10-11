# Report output contract

Return **only** JSON in this shape. The website renders it directly.

```json
{
  "stack": "React + Vite, Supabase, Stripe",
  "verdict": "fix_before_launch",
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

- `verdict` is exactly one of `ready`, `fix_before_launch`, `rework_foundation`, or `do_not_launch`.
- `step` is one of the ids in `references/steps.md`. Give every step at least one finding, in step order.
- `evidence` is `verified` or `inferred`.
- `fix` is only on `risk` findings: one sentence the owner can paste into their AI agent.
- 6–14 findings. 2–5 unknowns.
