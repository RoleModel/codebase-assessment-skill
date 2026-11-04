# OpenAI plugin submission

What to enter at [platform.openai.com/plugins](https://platform.openai.com/plugins) to list Codebase Assessment in the ChatGPT and Codex plugin directory. OpenAI's guide: [Submit plugins](https://developers.openai.com/plugins/deploy/submission).

## Before you submit

- [ ] You are an owner of the RoleModel organization on platform.openai.com, or you have the **Apps Management Write** role.
- [ ] RoleModel Software has completed business verification (organization settings).
- [ ] The demo video is recorded and a reviewer can open its link (see [Demo video](#demo-video)).
- [ ] `version` in `.codex-plugin/plugin.json` is higher than the last version you submitted.

## Build the package

```bash
./scripts/build-openai-zip.sh
```

This writes `dist/codebase-assessment-openai-<version>.zip`. The zip holds only the manifest, the icons, the license, and the skill. `evals/` stays out, because its sample apps have fake secrets that the scanner would flag.

## Create the draft

1. Open [platform.openai.com/plugins](https://platform.openai.com/plugins) and select **Create plugin**.
2. Choose **Skills only**.
3. For **Developer identity**, choose RoleModel Software.
4. Select **Upload plugin** and choose the zip.
5. If **Metadata & Skills** shows issues, fix them, build the zip again, and upload it again.

The plugin is desktop only (`requires_local_executor: true`), because it reads code on the user's computer. If the portal says that field is not allowed, send RoleModel's organization ID (organization settings) to an OpenAI contact and ask for submission access.

## Listing fields

The manifest fills these in. Check that each one is there after the upload.

| Field | Value |
|---|---|
| `displayName` | Codebase Assessment |
| `shortDescription` | Ship, Harden, Rebuild, Retire |
| `developerName` | RoleModel Software |
| `category` | Developer Tools |
| `websiteURL` | https://rolemodelsoftware.com |
| `supportURL` | https://github.com/RoleModel/codebase-assessment-skill/issues |
| `privacyPolicyURL` | https://rolemodelsoftware.com/privacy-policy |
| `termsOfServiceURL` | https://github.com/RoleModel/codebase-assessment-skill/blob/main/LICENSE |
| `logo` | `assets/logo.png` (180×180) |
| `composerIcon` | `assets/composer-icon.png` (64×64) |

## Review information

### Test setup for reviewers

Paste this into **Review information → Review details**:

> No account or sign-in is needed. The plugin reads a code repository on the reviewer's computer. To get the three sample apps, clone https://github.com/RoleModel/codebase-assessment-skill. Then, for each app, make an empty folder and run that app's `evals/<app>/place-files.sh` from inside it. Each script copies the app into the folder and builds its git history. The secrets in the sample apps are fake. Open the folder as the working directory in a local ChatGPT desktop or Codex thread, then send the prompt.

### Positive test cases

Each case uses the `codebase-assessment` skill.

1. **Lovable app that leaks keys**
   - Folder: `lovable-supabase-stripe-leaks`
   - Prompt: "I built a booking app for my widget repair shop in Lovable and I'm about to share it with customers and start taking card payments. Can you vibe check it?"
   - `tools_triggered`: codebase-assessment
   - `expected_behavior`: A **Harden** verdict. It names the Stripe secret key in browser code, the unsigned webhook, the `profiles` table with no row-level security, and the paid flag set in the browser. It does not print the key.

2. **Next.js app ready to ship**
   - Folder: `nextjs-clean-ship`
   - Prompt: "Our two-person team built this Next.js order app with Cursor. Before we turn on live Stripe payments next week, vibe check it and tell us straight if it's ready."
   - `tools_triggered`: codebase-assessment
   - `expected_behavior`: A **Ship** verdict. It credits the verified Stripe webhook, server-side prices, and orders scoped to each user. It does not invent blocking risks.

3. **Rails app with no user model**
   - Folder: `rails-no-user-model`
   - Prompt: "My nephew built our order tracker with Replit Agent. We want to let customers log in and see their own orders. Is it ready for that or do we need to start over?"
   - `tools_triggered`: codebase-assessment
   - `expected_behavior`: A **Rebuild** verdict. It names the missing user model, orders not tied to anyone, the shared hard-coded password, `permit!`, and the master key in git history. It does not print the key.

4. **Direct request**
   - Folder: `nextjs-clean-ship`
   - Prompt: "Run a codebase assessment on this repo."
   - `tools_triggered`: codebase-assessment
   - `expected_behavior`: A JSON report in the shape of `templates/report.md`, with one of the four verdicts, findings for all eight Assessment Areas in order, a file path on each finding, and an architecture map.

5. **Payments question**
   - Folder: `lovable-supabase-stripe-leaks`
   - Prompt: "Is it safe to take payments with this app?"
   - `tools_triggered`: codebase-assessment
   - `expected_behavior`: An assessment whose payment findings name the browser-side secret key and the unsigned webhook, each with a file path and a fix.

### Negative test cases

The skill must not start for these.

1. Prompt: "Write a haiku about autumn." Expected: a haiku. No assessment.
2. Prompt: "Explain what a React useEffect hook does." Expected: a short explanation. No assessment.
3. Folder: `lovable-supabase-stripe-leaks`. Prompt: "Rename `amountCents` to `priceCents` in `src/lib/stripe.ts`." Expected: the edit only. No assessment.

## Release notes

`publication.release_notes` for 1.0.0:

> First release. Assesses an app built mostly with an AI coding tool (Lovable, Bolt, v0, Replit, Cursor, Claude Code) across eight Assessment Areas and returns a Ship, Harden, Rebuild, or Retire verdict, with file-level findings and an architecture map.

## Demo video

`demo_recording_url` must be a link a reviewer can open without signing in. Keep the video to 2–3 minutes:

1. Install the plugin in the ChatGPT desktop app.
2. Open the `lovable-supabase-stripe-leaks` sample folder in a local thread.
3. Send test case 1 and show the skill start.
4. Show the Harden verdict and two findings with their file paths.
5. Send negative case 1 and show that no assessment starts.

## After approval

Open the approved version and select **Publish plugin**. To update it later, raise `version` in `.codex-plugin/plugin.json` and `.claude-plugin/marketplace.json`, build the zip again, and select **Upload plugin to make changes**. Each upload gets its own review.
