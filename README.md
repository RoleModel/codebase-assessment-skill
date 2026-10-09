# vibe-check skill

The Vibe Check skill RoleModel uses to assess apps built with AI coding tools.

```
vibe-check/
  SKILL.md               # instructions
  references/steps.md    # the steps the check walks through
  references/verdicts.md # Ship / Harden / Rebuild / Retire
  stacks/*.md            # stack-specific notes
  templates/report.md    # output contract the website renders
```

**Live:** the Vibe Check API reads these files from `main` at request time (cached ~1 minute), so a commit here updates rolemodelsoftware.com/ai-services/vibe-check without a redeploy. Keep `templates/report.md`'s JSON shape stable, or update the website component with it.

**Install** (once published to skills.sh): `npx skills add RoleModel/vibe-check-skill`
