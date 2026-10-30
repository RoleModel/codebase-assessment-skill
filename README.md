# Codebase Assessment skill

The Codebase Assessment skill RoleModel uses to evaluate apps built with AI coding tools.

```
codebase-assessment/
  SKILL.md               # instructions
  references/steps.md    # the eight Assessment Areas the check walks through
  references/verdicts.md # Ship / Harden / Rebuild / Retire
  stacks/*.md            # stack-specific notes
  templates/report.md    # output contract the website renders
evals/                   # test cases, kept outside the skill so runs can't see the graders
  <case>/prompt.md       # what the user types
  <case>/files/          # the sample app
  <case>/place-files.sh  # copies the app into an empty folder and builds its git history
  <case>/graders/        # one check per file
```

**Testing a change:** run each case in `evals/` with the changed skill and with the last commit's skill, and compare. Each sample app has a planted answer: Harden (Lovable), Ship (Next.js), Rebuild (Rails). Run `place-files.sh` from an empty folder to get the repo. The secrets in the sample apps are fake.

**Live:** the Codebase Assessment API reads these files from `main` at request time (cached ~1 minute), so a commit here updates the assessment without a redeploy. Keep `templates/report.md`'s JSON shape stable, or run the API repository's `npm run sync-skill` command when the contract changes.

**Install:** `npx skills add RoleModel/codebase-assessment-skill`
