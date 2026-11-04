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

## Install

**Any agent (Claude Code, Codex, Cursor, and more):**

```bash
npx skills add RoleModel/codebase-assessment-skill
```

**Claude Code plugin:**

```bash
claude plugin marketplace add RoleModel/codebase-assessment-skill
```

```bash
claude plugin install codebase-assessment@codebase-assessment
```

In a session, `/plugin marketplace add RoleModel/codebase-assessment-skill` does the same. Then run `/codebase-assessment:codebase-assessment`, or ask for a codebase assessment.

**Claude Desktop and claude.ai:** download [codebase-assessment.zip](https://github.com/RoleModel/codebase-assessment-skill/releases/latest/download/codebase-assessment.zip), then upload it under Customize > Skills. In the Desktop app's Code tab, the plugin steps above also work.

**Codex and ChatGPT:**

```bash
codex plugin marketplace add RoleModel/codebase-assessment-skill
```

```bash
codex plugin add codebase-assessment@codebase-assessment
```

After you add the marketplace, the ChatGPT desktop app also lists it in the Plugins Directory (Work mode or Codex). Restart the app to see it.

## Packaging

The skill stays in `codebase-assessment/`, because the API reads it from there. Each package points at that folder:

- `.claude-plugin/marketplace.json`: Claude Code plugin marketplace.
- `.codex-plugin/plugin.json` and `.agents/plugins/marketplace.json`: Codex and ChatGPT plugin.
- `.github/workflows/skill-zip.yml`: builds the zip for Claude Desktop and claude.ai on each change to the skill.

When you change the skill, bump `version` in `.claude-plugin/marketplace.json` and `.codex-plugin/plugin.json` so installed copies update.
