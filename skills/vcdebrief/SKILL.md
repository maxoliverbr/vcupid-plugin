---
name: vcdebrief
description: "Debrief a VC meeting and produce a follow-up email, open diligence queue, and next-step recommendation. Usage: /vcdebrief <vcmatch-report.md>. Reads STARTUP_PROFILE.md and the vcmatch report. Saves to vcdebrief-<fund>.md."
license: MIT
allowed-tools: Read Write
metadata:
  author: 3Flux
  version: "1.0"
  workflow-step: "9 — run after /vcprep, after the meeting"
---

# /vcdebrief — Post-Meeting Debrief

Turn your raw meeting memory into a structured debrief: a signal read, an open diligence queue, a send-ready follow-up email, and a clear recommended next step.

## Invocation

```
/vcdebrief <vcmatch-report.md>
```

Example: `/vcdebrief vcmatch-a16z.md`

## Execution Steps

### Step 1 — Load Context

Read two files:

1. `STARTUP_PROFILE.md` — extract: company name, founder names, raise amount, key traction points
2. The vcmatch report passed as argument — extract:
   - Fund name and target partner name
   - Fit Score and Recommended Action
   - Diligence questions listed in the report (the ones the fund was predicted to ask)
   - Red flags identified in the report
   - Optimal pitch angle and opening hook

Derive fund slug and output filename: `vcmatch-a16z.md` → fund = `a16z`, output = `vcdebrief-a16z.md`

If either file is missing, stop and tell the user which file to provide.

### Step 2 — Gather Meeting Notes

Ask the user:

> "Describe what happened in the meeting. Include as much as you can remember:
> - Who was in the room (names, titles)
> - Approximately how long it ran
> - Questions they asked — exact wording if you remember it
> - What they reacted positively to (leaned in, followed up, wrote something down)
> - What they pushed back on or questioned
> - Any signals about their interest level (tone, pace, next steps they mentioned)
> - Anything surprising — questions you didn't expect, topics they raised unprompted"

Wait for the user's response before continuing. Do not proceed with a placeholder.

### Step 3 — Analyze the Meeting

Map the user's notes against the vcmatch report:

**Diligence prediction accuracy:**
- Which predicted diligence questions actually came up? Which didn't?
- What new questions emerged that the vcmatch didn't anticipate?

**Signal classification:**
- Green signals: things they reacted positively to, questions that showed interest, next-step offers
- Yellow signals: surface-level engagement, polite skepticism, short follow-up questions
- Red signals: direct challenges, unanswered objections, signals of misalignment ("that's not really our area")

**Pitch landing assessment:**
- Did the vcmatch opening hook land? Did they engage with the pitch angle?
- Which red flags from the vcmatch came up? Were they addressed?
- What surprised you — positively or negatively — compared to what the vcmatch predicted?

### Step 4 — Draft Follow-Up Email

Write a send-ready follow-up email to the target partner. Rules:
- Send within 24 hours — the subject line should signal immediacy without being desperate
- Subject: ≤8 words — reference something specific from the meeting, not a generic "Following up"
- Body: 4–6 sentences
  1. One sentence of genuine gratitude — reference something specific they said or asked
  2. One sentence that reinforces the thesis alignment that resonated most
  3. One or two sentences that address any open diligence items they raised — with brief answers or offers to send materials
  4. Clear next step ask — specific (second call, partner meeting, data room access) with a soft time anchor

Format:
```
Subject: [subject line]

[Body — 4–6 sentences]

[Founder Name]
[Title], [Company]
[Website]
```

### Step 5 — Produce Output and Save

Write the full debrief to `vcdebrief-<fund>.md` using the output format in `references/output-format.md`.

Then tell the user:
- "Send the follow-up email within 24 hours — response rate drops sharply after that."
- "Run `/vctrack` to update your pipeline view."
- If Recommended Next Step is "Drop Fund": "This one looks like a no — move your energy to the next fund on the list."

---

## Output Rules

- The Signal Read must be grounded in the user's actual notes — no invented signals
- The Diligence Queue table must only include questions that were actually raised in the meeting, plus any from the vcmatch that remain open
- The follow-up email must reference something specific from the meeting — never a generic opener
- The Recommended Next Step must be one of the five defined options (see output format) — do not invent new categories
- Updated Fit Signal must honestly reflect what the meeting revealed — it is allowed to be worse than the vcmatch prediction
- Word budget: ≤1,400 words total across all sections
