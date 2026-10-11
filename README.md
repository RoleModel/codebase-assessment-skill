# Codebase Assessment skill

The Codebase Assessment skill RoleModel uses to evaluate apps built with AI coding tools.

```
codebase-assessment/
  SKILL.md               # instructions
  references/steps.md    # the steps the check walks through
  references/verdicts.md # Ready / Fix before launch / Rework / Do not launch
  stacks/*.md            # stack-specific notes
  templates/report.md    # output contract the website renders
```

**Live:** the Codebase Assessment API reads these files from `main` at request time (cached ~1 minute), so a commit here updates the assessment without a redeploy. Keep `templates/report.md`'s JSON shape stable, or run the API repository's `npm run sync-skill` command when the contract changes.

**Install:** `npx skills add RoleModel/codebase-assessment-skill`
