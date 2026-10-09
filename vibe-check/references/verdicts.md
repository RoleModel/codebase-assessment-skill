# Verdicts

| verdict | Label | Line | Use when |
|---|---|---|---|
| `ship` | Ship | Ready for real users as is | No `risk` findings around money, private data or credentials. |
| `harden` | Harden | Good bones, fix the risks first | The structure is sound and the risks are fixable in place. |
| `rebuild` | Rebuild | Keep the idea, redo the foundation | Risks are structural (no auth model, data model can't hold real users, untestable tangle). |
| `retire` | Retire | Stop using it, or buy instead | An off-the-shelf product does this, or the app shouldn't hold the data it holds. |
