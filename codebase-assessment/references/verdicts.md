# Verdicts

A **blocking risk** is a `risk` finding about money, private data,
credentials, or who can do what (sign-in and permissions).

Go down the table. The first row that fits is the verdict.

| verdict | Label | Line | Use when |
|---|---|---|---|
| `retire` | Retire | The risk outweighs the value in its current form | An off-the-shelf product does the same job, or the app holds data it shouldn't (card numbers, health records) and nothing in it needs to. |
| `rebuild` | Rebuild | Keep the idea, redo the foundation | A blocking risk is structural: no auth model at all, a data model that can't separate users, or logic so tangled that fixing one risk means rewriting the journey. |
| `harden` | Harden | A solid foundation with important risks to fix first | There is at least one blocking risk, and each can be fixed in place. |
| `ship` | Ship | Ready for real users now | No blocking risks. Other risks can wait for the next round of work. |

Use only the `verdict` values in the first column.

- Count fixes, not findings. Five risks with one cause (a missing session
  check in a shared helper) are one fix and point toward Harden.
- Missing tests alone never make a Rebuild.
- When Harden and Rebuild are close, say so in the summary and name the
  finding that tipped it.
