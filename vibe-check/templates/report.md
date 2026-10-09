# Report output contract

Return **only** JSON in this shape. The website renders it directly.

```json
{
  "stack": "Next.js + Supabase",
  "verdict": "fix-first",
  "score": 72,
  "headline": "Close — fix data access before you invite real users.",
  "summary": "Two or three sentences in plain language.",
  "checks": [
    {
      "id": "access",
      "name": "Data access",
      "status": "fail",
      "finding": "What you found, in one or two sentences.",
      "files": ["supabase/migrations/001_init.sql"]
    }
  ],
  "strengths": ["One line each, things done well."],
  "fixes": [
    { "priority": 1, "title": "Short imperative", "detail": "One or two sentences on how." }
  ]
}
```

- `checks` has one entry per check in `references/checks.md`, in that order.
- `fixes` has 3–5 items, highest risk first.
