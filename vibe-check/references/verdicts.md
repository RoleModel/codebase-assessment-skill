# Verdicts

| verdict             | Label                 | Line                                               | Use when                                                                                   |
| ------------------- | --------------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `ready`             | Ready to launch       | Suitable for real users now                        | No `risk` findings around money, private data or credentials.                              |
| `fix_before_launch` | Fix before launch     | A solid foundation with important risks to address | The structure is sound and the risks are fixable in place.                                 |
| `rework_foundation` | Rework the foundation | Keep the idea, but correct the underlying approach | Risks are structural (no auth model, data model can't hold real users, untestable tangle). |
| `do_not_launch`     | Do not launch         | The risk outweighs the value in its current form   | An off-the-shelf product does this, or the app shouldn't hold the data it holds.           |

Use only the canonical `verdict` values in the first column. Do not output the legacy values `ship`, `harden`, `rebuild`, or `retire`.
