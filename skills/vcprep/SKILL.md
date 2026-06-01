---
name: vcprep
description: "Prepare a 15-minute VC pitch meeting from the active startup profile and a vcmatch report. Usage: /vcprep <vcmatch-report.md>. Produces a complete meeting prep: timed agenda, opening hook, slide-by-slide talking points, preemptive answers to the fund's likely diligence questions, red flag rebuttals, and a clear ask."
license: MIT
allowed-tools: Read Write
metadata:
  author: 3Flux
  version: "1.0"
  workflow-step: "10 — run after /vcmatch when a meeting is booked"
---

# /vcprep — 15-Minute VC Pitch Meeting Prep

Prepare the founders for a 15-minute pitch meeting with a specific VC fund, using the startup profile and a previously generated vcmatch report.

## Invocation

```
/vcprep <vcmatch-report.md>
```

Example: `/vcprep vcmatch-a16z.md`

## Execution Steps

### Step 1 — Load Context

Read the following files:

1. `STARTUP_PROFILE.md` from the current working directory — extract company, founders, problem, solution, traction, business model, stage, team.
2. The vcmatch report file passed as the argument — extract: Fund Overview, Mandate Alignment verdict, Fit Score rationale, Optimal Pitch Angle (opening hook + target partner + what to lead/avoid), Red Flags, and Diligence Questions.
3. `vcperks-<fund-slug>.md` — if it exists in the current directory, load the Top 3 Perks section. These are used in The Ask segment to articulate value beyond capital when the partner asks "why us specifically?"

If files 1 or 2 are missing, stop and tell the user which one is absent. File 3 is optional — if absent, skip the perks references.

### Step 2 — Produce the Meeting Prep

Output a structured prep document. Use the vcmatch report to make every section fund-specific — generic pitch advice is useless here.

---

## Output Structure

```
# Pitch Prep: [Startup] x [Fund] — 15-Minute Meeting
Target partner: [Name from vcmatch]
Fit score: [XX/100 from vcmatch]
```

---

### AGENDA — 15 Minutes

A strict, timed breakdown the founders should memorize and rehearse to:

| Min | Segment | Goal |
|-----|---------|------|
| 0:00–1:00 | Opening Hook | Land the one sentence that makes the partner lean forward |
| 1:00–3:00 | The Problem | Make them feel the pain — use their own language from their published thesis |
| 3:00–5:00 | The Solution | The "aha" moment — why now, why us, why this approach |
| 5:00–7:00 | Traction & Validation | Proof it's real — don't oversell, be precise |
| 7:00–9:00 | Market & Business Model | Size, wedge, and how money flows |
| 9:00–10:00 | Team | 60 seconds max — credentials that matter for THIS fund |
| 10:00–11:00 | The Ask | Amount, use of funds, milestone it unlocks |
| 11:00–15:00 | Q&A | Controlled — you drive the conversation back to strengths |

---

### SEGMENT SCRIPTS

For each segment above, write:
- **What to say** (2–4 sentences, verbatim-ready talking points tailored to this fund)
- **What to show** (slide or visual recommendation)
- **What NOT to say** (pitfalls specific to this fund's known sensitivities from the vcmatch report)

Use the vcmatch "Optimal Pitch Angle" section to shape the language. Use the vcmatch "Red Flags" section to inform what to avoid or preempt.

---

### PREEMPTIVE ANSWERS — Diligence Questions

For each question listed in the vcmatch report's "Diligence Questions to Prepare" section, write:

**Q: [question verbatim from vcmatch]**
**A:** [Crisp, honest 2–4 sentence answer. If the answer exposes a weakness, acknowledge it briefly and pivot to what you're doing about it. Do not bluff.]
**If they push:** [One follow-up sentence if they press harder]

---

### RED FLAG REBUTTALS

For each red flag from the vcmatch report, write a 1–2 sentence rebuttal or mitigation the founders can deploy if it surfaces in conversation. Label each by the red flag name.

Format:
- **[Red Flag Name]**: [Rebuttal — honest, not defensive. Acknowledge + reframe toward strength.]

---

### THE ASK

Based on the startup profile stage and the fund's typical check size from the vcmatch report, specify:
- Exact amount to ask for (be specific, not a range)
- What milestone this capital unlocks (one crisp sentence)
- What the next 90 days look like if they say yes
- **Value beyond capital:** If a vcperks report was loaded, name the 1–2 most relevant perks for this startup and note them here — founders should be able to say "beyond the capital, we're specifically interested in [X] because [startup-specific reason]" when the partner asks why them. Keep it to one sentence.
- The leave-behind: one thing to send them within 24 hours of the meeting

---

### MEETING DISCIPLINE

Three rules the founders must follow in the room:

1. **Time**: If Q&A hasn't started by minute 11, say "I want to leave time for your questions — let me pause there." Never run over.
2. **Control**: When a hard question surfaces, answer it in 2 sentences and redirect: "Can I show you the traction data that's relevant here?" — keep the conversation moving toward strengths.
3. **Close**: Before leaving, ask explicitly: "What would you need to see to move forward?" — get a concrete next step, not a vague "we'll be in touch."

---

## Output Format

- Use markdown headers, tables, and bullets
- Every section must be fund-specific — draw from the vcmatch report throughout
- Keep total length under 1,200 words
- Bold the most important sentence in each segment script
- Do not include generic VC pitch advice that isn't grounded in this specific fund's mandate
