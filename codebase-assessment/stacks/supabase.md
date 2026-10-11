# Supabase

- Row Level Security must be enabled on every table that holds user data; check `supabase/migrations` for `enable row level security` and policies.
- The `service_role` key must never appear in client code or `NEXT_PUBLIC_` / `VITE_` env vars.
- Edge functions that change data should check `auth.uid()`.
