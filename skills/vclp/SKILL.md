---
name: vclp
description: "Generate a fund-specific one-page executive summary from a vcmatch report. Usage: /vclp <vcmatch-report.md>. Reads STARTUP_PROFILE.md and the vcmatch report, then produces a one-pager written entirely in the fund's language and framed around their thesis. Saves to vclp-<fund>.md."
---

# /vclp — Fund-Specific One-Pager

Generate a one-page executive summary tailored to a specific VC fund's language, thesis, and priorities. Every sentence is written for this fund — not a generic company description.

## Invocation

```
/vclp <vcmatch-report.md>
```

Example: `/vclp vcmatch-a16z.md`

## Execution Steps

### Step 1 — Load Context

Read two files:

1. `STARTUP_PROFILE.md` — extract: company name, one-liner, founders, traction figures, business model, ask amount, website, founding date
2. The vcmatch report passed as argument — extract:
   - Fund name and target partner
   - Fit score
   - Fund thesis language (verbatim quotes from Fund Overview section)
   - Opening hook (from Optimal Pitch Angle)
   - Mandate alignment table — which dimensions scored well, which didn't
   - Top traction proof points most relevant to this fund
   - Red flags (to avoid mentioning or to reframe)

Derive fund slug and output filename: `vcmatch-a16z.md` → `vclp-a16z.md`

If either file is missing, stop and tell the user which one to provide.

If fit score is below 50, warn the user: "⚠️ Fit score is [X]/100. This one-pager will reflect a weak mandate match — consider running `/vcmatch` on a better-fit fund first."

### Step 2 — Produce the One-Pager

Write `vclp-<fund>.md` using this structure. Every section must use the fund's own language from the vcmatch report — not the startup's generic description. The test: would this paragraph make sense on the fund's own portfolio page?

Keep the total body to ≤500 words. No bullet-within-bullet nesting. Clean, scannable.

---

```markdown
# [Startup Name]
**[One-liner reframed in the fund's thesis language — not the generic startup one-liner]**

[Fund Name] · Confidential · [Date] · [Fit Score]/100

---

## The Problem
[2–3 sentences using the fund's own published framing of the problem.
Use their language — verbatim phrases from their thesis essays or the vcmatch Fund Overview where possible.
The fund partner should read this and think "this is exactly what we've been writing about."]

## The Solution
[2–3 sentences describing the solution mapped to how this fund talks about solutions in their portfolio.
Reference their portfolio company language as a frame where relevant.
Lead with the mechanism that scored highest in the mandate alignment table.]

## Traction
[3–4 bullet points — only the proof points that scored highest with this fund from the mandate alignment assessment.
Include figures. Cut anything that didn't score well for this fund's priorities.]

- [Proof point 1 with figure]
- [Proof point 2 with figure]
- [Proof point 3 with figure]

## Market
[2 sentences. Size the market in terms this fund cares about.
Lead with the beachhead figure, then the expansion path.
If the fund cares about national interest / policy impact, frame the market that way, not just in dollar terms.]

## Team
[2–3 sentences covering only the credentials that scored well in the vcmatch team fit assessment.
Filter out credentials the fund doesn't weight (e.g., if it's a deep tech fund, lead with EE/physics background, not general business experience).
Name both founders with their most relevant credential.]

## The Ask
**$[Amount] · [Instrument: SAFE / Priced Seed]**
[One sentence: what this capital funds and what milestone it unlocks.]
[One sentence: timeline to next fundable moment — the proof point that positions for Series A.]

## Why Now
[2 sentences: fund-specific urgency. Tie to market timing the fund has written about, a portfolio company dynamic, or a regulatory/policy window.
This is not generic "the market is ready" language — it references something specific to this fund's thesis.]

---

_[Startup website] · [Founder name], [Title] · [Email or contact]_

⚠️ Optimized for [Fund Name]. Do not send to other funds without running `/vcmatch <fund>` first — this one-pager uses [Fund Name]-specific language throughout.
```

---

## Output Rules

- Every paragraph must draw from the vcmatch report — no generic startup language
- The headline one-liner must differ from STARTUP_PROFILE.md — it must use the fund's thesis framing
- Red flags from the vcmatch must not appear in this document — either reframe them as strengths or omit them
- Total body ≤500 words — if a section runs long, cut it; this is a one-pager, not a deck
- The footer warning is mandatory — always include it
- After saving, tell the user: "Send this with `/vcintro` variant A or B — it replaces a deck at this stage."
