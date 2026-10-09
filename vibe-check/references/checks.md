# Checks

Run each check. Status is one of `pass`, `warn`, `fail`, `unknown`.

| id | Check | Fail when… |
|---|---|---|
| `secrets` | Secrets & keys | API keys, tokens or passwords are committed, or secret keys are used in client-side code. |
| `auth` | Authentication | Sign-in is hand-rolled, sessions never expire, or protected pages are only hidden in the UI. |
| `access` | Data access | Any user can read or change another user's data (missing row-level security, unscoped queries, IDs trusted from the client). |
| `payments` | Payments | Prices or amounts come from the client, webhooks aren't verified, or paid features aren't checked on the server. Mark `unknown` if there are no payments. |
| `input` | Input handling | User input reaches the database, shell or HTML without validation or escaping. |
| `errors` | Errors & logging | Errors are swallowed, stack traces reach users, or there's no way to see production failures. |
| `tests` | Tests | No automated tests around sign-in, payments, or core data changes. |
| `deps` | Dependencies | Abandoned or badly outdated packages, or many unused ones. |
| `deploy` | Deploy & config | No separate production config, debug mode on, or no backups for the database. |
