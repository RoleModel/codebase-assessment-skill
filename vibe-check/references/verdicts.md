# Verdicts

| verdict | Label | Use when |
|---|---|---|
| `ship` | Ready to ship | No `fail`s, at most two `warn`s, nothing risky around money or private data. |
| `fix-first` | Fix these first | Any `warn` around secrets, access or payments, or one `fail` that's quick to fix. |
| `not-ready` | Not ready for real users | Any `fail` in secrets, auth, access or payments that needs real rework. |

Score (0–100): start at 100, −15 per `fail`, −5 per `warn`, −3 per `unknown`. Floor at 0.
