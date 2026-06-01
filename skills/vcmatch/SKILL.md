---
name: vcmatch
description: "Match the active startup profile against a VC fund. Usage: /vcmatch <VC Fund Name>. Reads STARTUP_PROFILE.md, researches the fund, and produces a structured VC Match Report with fit score, mandate alignment, pitch angle, red flags, diligence questions, and a pursue/no-go recommendation."
license: MIT
compatibility: Requires Claude Code with WebSearch and WebFetch. Internet connection required.
allowed-tools: WebSearch WebFetch Read Write
metadata:
  author: 3Flux
  version: "1.0"
  workflow-step: "4 — run after /vcposer scores 60+"
---

# /vcmatch — VC Match Analysis

Match the active startup profile against a VC fund and produce a structured, scored VC Match Report.

## Invocation

```
/vcmatch <VC Fund Name>
```

Example: `/vcmatch a16z` or `/vcmatch Lowercarbon Capital`

## Execution Steps

When invoked, execute these three steps in order.

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md` from the current working directory. Extract and hold in context:

- Company name and one-liner
- Core problem and solution
- Target customer and market size
- Business model and pricing
- Current stage, traction, and milestones
- Team backgrounds and relevant credentials
- Geography and founding date

If `STARTUP_PROFILE.md` does not exist, stop and tell the user to create it first.

### Step 2 — Research the VC Fund

**Poser pre-check:** Before beginning research, look for a `vcposer-<fund-slug>.md` file in the current working directory (derive the slug the same way as the output filename). If it exists:
- Read the Poser Score and verdict.
- If score is **below 40**: stop and tell the user — "This fund scored [X]/100 on the poser check — the red flags suggest this fund may not be actively deploying capital. Investigate those findings or re-run `/vcposer <fund>` if conditions have changed before spending time on a full match analysis."
- If score is **40–59**: continue with research but add a warning banner at the top of the output report: `⚠️ Poser Score: [X]/100 (Watch List) — this fund shows legitimacy concerns. De-prioritize unless a warm intro exists.`
- If score is **60+** or no vcposer file exists: proceed normally.

Use WebSearch (and WebFetch on key pages like the fund's website, team pages, and portfolio pages) to gather:

- Investment thesis and mandate (verbatim quotes where possible)
- Stage focus (pre-seed / seed / Series A / growth)
- Sector and vertical focus (deep tech, climate, enterprise SaaS, etc.)
- Geography preference
- Typical check size and fund size
- Portfolio companies — especially recent investments in the last 2 years
- Key partners, their backgrounds, and their stated focus areas
- Any thesis essays, blog posts, or public statements about what they invest in
- Any known portfolio conflicts or "too close to portfolio" sectors

Search queries to use:
1. `"<Fund Name>" investment thesis portfolio stage`
2. `"<Fund Name>" recent investments 2024 2025`
3. `"<Fund Name>" partners focus sectors check size`
4. `site:<fund-website> thesis` (if website is known)

### Step 3 — Produce the VC Match Report

Output a structured markdown report with exactly these seven sections:

---

## VC Match Report: [Fund Name] x [Startup Name]

### 1. Fund Overview
Thesis, stage focus, sector/vertical, check size, fund size, geography, key partners (with their focus areas). Keep to 5-8 bullets.

### 2. Mandate Alignment
Line-by-line comparison of the fund's stated criteria against the startup's profile. Use a table or bullet pairs:
- Stage match: fund's stage vs startup's current stage
- Sector match: fund's verticals vs startup's category
- Business model match: fund preferences vs startup's pricing model
- Geography match
- Team match: fund's team preferences vs startup's credentials
- Traction match: fund's typical entry bar vs startup's current milestones

### 3. Fit Score
**Score: XX/100**

Break down the score across: sector fit, stage fit, team fit, traction fit, thesis alignment. Provide 2-3 sentences of rationale. Be honest — a 45/100 with clear reasoning is more useful than an inflated score.

### 4. Optimal Pitch Angle
What to lead with when pitching THIS specific fund. Identify:
- Which element of the startup maps best to this fund's thesis
- Which partner to target (by name and focus) and why
- The 1-2 sentence opening hook tailored to this fund's language
- What NOT to lead with (points that may not resonate)

### 5. Red Flags
Honest assessment of mandate mismatches, portfolio conflicts, or thesis gaps. Flag:
- Stage mismatch (too early / too late)
- Sector overlap with existing portfolio
- Missing proof points this fund typically requires
- Geographic or structural concerns

### 6. Diligence Questions to Prepare
List 5-8 questions this fund is likely to ask, based on their thesis and portfolio pattern. Make them specific, not generic.

### 7. Recommended Action
One of three verdicts with a 2-3 sentence rationale:

- **Pursue** — strong fit, prioritize outreach now
- **Warm Up First** — fit exists but missing a proof point; revisit in N months after X milestone
- **No-Go** — material mandate mismatch; explain why and suggest what would need to change

---

## Output Format

- Use markdown headers and bullets throughout
- Keep the full report under 800 words
- Cite sources inline where possible (e.g., "per their 2024 thesis post")
- Do not pad — if a section has nothing meaningful, say so in one sentence
