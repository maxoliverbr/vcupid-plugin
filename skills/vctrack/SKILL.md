---
name: vctrack
description: "Scan all vc*.md output files and generate a pipeline status dashboard. Usage: /vctrack. Reads vcmatch/vcposer/vcintro/vcprep/vcdebrief files in the current directory. Saves to vctrack.md."
license: MIT
allowed-tools: Read Write Bash(find:*)
metadata:
  author: 3Flux
  version: "1.0"
  workflow-step: "meta — run anytime to review pipeline status"
---

# /vctrack — VC Pipeline Dashboard

Scan all vcupid output files in the current directory and produce a single pipeline status table showing where every fund stands, what's stale, and what needs to happen next.

## Invocation

```
/vctrack
```

No argument needed. Reads from the current working directory.

## Execution Steps

### Step 1 — Scan for Pipeline Files

Run: `find . -maxdepth 1 -name "vc*.md" -not -name "vctrack.md"` to list all output files in the current directory.

If no vc*.md files are found (other than vctrack.md itself), stop and tell the user: "No vcupid output files found in this directory. Run `/vclist` or `/vcmatch <fund>` first to build your pipeline."

Group the files by fund slug. The fund slug is derived from the filename:
- `vcmatch-a16z.md` → slug = `a16z`
- `vcposer-slow-ventures.md` → slug = `slow-ventures`
- `vcpartner-a16z-price-wright.md` → slug = `a16z` (partner files belong to the fund slug before the second `-`)
- `vcraise.md`, `vclist.md`, `vcdevil.md` → these are not fund-specific, skip them

Build a fund registry: one entry per unique slug.

### Step 2 — Extract Status for Each Fund

For each fund in the registry, read the available files and extract:

**From `vcposer-<fund>.md`** (if it exists):
- Poser Score (the number out of 100)
- Verdict line (Legit / Probable / Watch List / Likely Poser)

**From `vcmatch-<fund>.md`** (if it exists):
- Fit Score (the number out of 100)
- Recommended Action (Pursue / Warm Up First / No-Go)

**Presence checks** (read if file exists, note presence only):
- `vcintro-<fund>.md` → outreach drafted: Yes / No
- `vcprep-<fund>.md` → meeting prepped: Yes / No
- `vcdebrief-<fund>.md` → meeting debriefed: Yes / No
- `vcpartner-<fund>-*.md` → partner profiled: Yes / No (check with `find . -maxdepth 1 -name "vcpartner-<fund>-*.md"`)

### Step 3 — Compute Pipeline Stage

For each fund, assign the furthest stage reached based on which files exist:

| Stage | Condition |
|-------|-----------|
| **Debriefed** | vcdebrief exists |
| **Meeting Prepped** | vcprep exists, no vcdebrief |
| **Outreach Sent** | vcintro exists, no vcprep |
| **Matched** | vcmatch exists, no vcintro |
| **Screened** | vcposer exists, no vcmatch |

### Step 4 — Flag Stale and Urgent Situations

Scan for these conditions and collect them as action flags:

- **Outreach Not Sent**: vcmatch Recommended Action is "Pursue" but no vcintro → "Run `/vcintro vcmatch-<fund>.md`"
- **Meeting Awaiting Debrief**: vcprep exists but no vcdebrief → "Run `/vcdebrief vcmatch-<fund>.md` after the meeting"
- **Poser Not Checked**: vcmatch exists but no vcposer → "Run `/vcposer <fund>` to verify fund legitimacy"
- **No-Go in Pipeline**: vcmatch Recommended Action is "No-Go" → "Consider dropping — vcmatch says No-Go"

### Step 5 — Produce Output and Save

Write the full dashboard to `vctrack.md`.

Then tell the user:
- How many funds are being tracked
- How many have urgent actions
- "Run `/vctrack` again at any time to refresh."

---

## Output Format

```markdown
# VC Pipeline Dashboard
_Generated: [date] | Directory: [current directory path]_

---

## Summary
- **Total funds tracked:** N
- **Active (Pursue / Warm Up):** N
- **No-Go / Dropped:** N
- **Funds with urgent actions:** N

---

## Pipeline Status

| Fund | Poser | Fit | Action | Stage | Partner | Next Step |
|------|-------|-----|--------|-------|---------|-----------|
| [slug] | [score or —] | [score or —] | [action or —] | [stage] | [Yes/No] | [next step] |

_Poser and Fit scores are shown as N/100. — means not yet run._

---

## Urgent Actions

[If none: "No urgent actions. Pipeline is up to date."]

1. **[Fund]** — [flag description] → [recommended command]
2. ...

---

## Pipeline Notes
- Funds at "Screened" stage: run `/vcmatch <fund>` to go deeper
- Funds at "Matched" stage: run `/vcintro vcmatch-<fund>.md` to draft outreach
- Funds at "Meeting Prepped" stage: run `/vcdebrief vcmatch-<fund>.md` after the meeting
```

---

## Output Rules

- Sort the pipeline table by: No-Go funds last, then by Fit Score descending
- Show `—` (not blank, not zero) for any score that hasn't been run yet
- The Next Step column must be a specific command or action — never "TBD" or blank
- Do not include `vcraise.md`, `vclist.md`, or `vcdevil.md` in the pipeline table — these are not fund-level files
- Word budget for the Urgent Actions section: ≤30 words per item
- If zero funds are found in the pipeline, do not create the output file — just report the error inline
