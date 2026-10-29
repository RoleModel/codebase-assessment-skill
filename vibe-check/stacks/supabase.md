# Supabase

Loaded when `package.json` names `@supabase/supabase-js`, or a `supabase/`
folder exists.

## Security sinks

- Every table with user data needs row-level security. Look in
  `supabase/migrations` for `enable row level security` and a `create policy`
  per operation. A policy of `using (true)` is the same as none.
- The `service_role` key must never appear in client code, or in a
  `NEXT_PUBLIC_` or `VITE_` env var. It skips every policy.
- Edge functions (`supabase/functions`) that change data must check
  `auth.uid()` or verify the JWT, and must not trust a `user_id` from the
  request body.
- Storage buckets marked public serve every file to anyone with the URL.

## Unknowns to list

Policies, buckets, and auth settings made in the dashboard rather than in
migrations.
