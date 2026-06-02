---
name: vcmatch
description: "Match the active startup profile against a VC fund. Usage: /vcmatch <VC Fund Name>. Reads STARTUP_PROFILE.md, researches the fund, and produces a structured VC Match Report with firm snapshot, thesis focus, key people, dimensional fit scoring, positive case, risks, pitch approach, and a verdict table."
license: MIT
compatibility: Requires Claude Code with WebSearch and WebFetch. Internet connection required.
allowed-tools: WebSearch WebFetch Read Write
metadata:
  author: 3Flux
  version: "2.0"
  workflow-step: "4 — run after /vcposer scores 60+"
---

# /vcmatch — VC Match Analysis

Match the active startup profile against a VC fund and produce a structured, scored VC Match Report.

## Invocation

```
/vcmatch <VC Fund Name>
```

Example: `/vcmatch a16z` or `/vcmatch Y Combinator`

## Execution Steps

When invoked, execute these three steps in order.

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md` from the current working directory. Extract and hold in context:

- Company name and one-liner
- CEO name and profile
- CTO name and profile
- Core problem and solution
- Target customer and market size
- Key value proposition
- Business model and pricing
- Current stage, traction, and milestones
- Team backgrounds and relevant credentials
- Geography and founding date
- Referral


If `STARTUP_PROFILE.md` does not exist, stop and tell the user to create it first.

### Step 2 — Research the VC Fund

**Poser pre-check:** Before beginning research, look for a `vcposer-<fund-slug>.md` file in the current working directory (derive the slug the same way as the output filename). If it exists:
- Read the Poser Score and verdict.
- If score is **below 40**: stop and tell the user — "This fund scored [X]/100 on the poser check — the red flags suggest this fund may not be actively deploying capital. Investigate those findings or re-run `/vcposer <fund>` if conditions have changed before spending time on a full match analysis."
- If score is **40–59**: continue with research but add a warning banner at the top of the output report: `⚠️ Poser Score: [X]/100 (Watch List) — this fund shows legitimacy concerns. De-prioritize unless a warm intro exists.`
- If score is **60+** or no vcposer file exists: proceed normally.

Use WebSearch (and WebFetch on key pages like the fund's website, team pages, and portfolio pages) to gather:

- Investment thesis and mandate (verbatim quotes where possible)
- Program model (accelerator, seed fund, multi-stage, etc.) and any mandatory time commitments
- Stage focus (pre-seed / seed / Series A / growth)
- Sector and vertical focus (deep tech, climate, enterprise SaaS, etc.)
- Geography preference
- Deal terms: standard equity %, check size structure, SAFE vs. priced round
- Fund/batch size and cadence
- Portfolio companies — especially sector analogs and recent investments in the last 2 years
- Recent batch or portfolio composition (thematic trends, % AI, notable cluster sectors)
- Key partners, their backgrounds, and their stated focus areas
- Any thesis essays, blog posts, or public statements about what they invest in
- Application/referral dynamics (open applications, referral advantage, partner assignment)
- Any known portfolio conflicts or "too close to portfolio" sectors

Search queries to use:
1. `"<Fund Name>" investment thesis portfolio stage`
2. `"<Fund Name>" recent investments 2024 2025 2026`
3. `"<Fund Name>" partners focus sectors check size`
4. `site:<fund-website> thesis` (if website is known)

### Step 3 — Produce the VC Match Report

Output a structured markdown report with exactly these eight sections:

---

## VC Match Report: [Fund Name] × [Startup Name]

### Firm Snapshot

Markdown table with these fields: Founded, Model, CEO, Key GPs, Standard Deal, Fund/Batch Size, Notable Portfolio/Alumni. Keep each cell concise.

### Investment Thesis & Current Focus

Table with columns **Theme** | **Signal**. List the fund's active investment themes as rows — distinguish de facto focus (what they're actually funding right now) from stated mandate. Include verbatim partner quotes where available. Note any thesis drift from prior years.

### Key People

Table with columns **Person** | **Role** | **Relevance to [Startup Name]**. List 3–6 decision-makers or relevant partners. After the table, add a plain-text note on HOW to approach (referral required? open application? partner assignment process?). Do not fabricate people or titles — caveat any uncertain data.

### Fit Assessment

**Overall Fit Score: X/10**

Table with columns **Dimension** | **Score** | **Rationale**. Score each of these dimensions: Sector Fit, Stage Fit, Check Size Fit, Thesis Alignment, Program/Network Value. Scores are out of 10. Be calibrated — a 5/10 with clear reasoning is more useful than an inflated 8/10.

### Why It Works

Bullet list of the strongest positive signals for pursuing this fund. Lead with concrete portfolio analogs (named companies + outcomes). Include narrative hooks, structural advantages, and timing factors that favor the startup right now.

### Key Risks & Objections

Numbered list of material risks and mandate mismatches. Where relevant, include specific math (dilution %, valuation impact, timing lock-in). Flag structural concerns (batch schedule, mandatory program overhead, check size constraints, portfolio conflicts). Be direct — omit risks that don't materially affect this specific startup.

### Best Approach

- **Intro strategy:** how to get a warm referral or bypass cold outreach (specific tactic for this fund)
- **Lead with:** 3–4 specific bullets — what to put front and center in the application, pitch deck, or first meeting
- **Avoid:** 1–2 things not to emphasize for this specific fund's current focus

### Cold email
Subject: [subject line]
---
[4-5 sentence email body. Open with a specific reference to their thesis or a recent portfolio company. State what 3Flux does in one sentence. Explain why 3Flux fits their mandate using the match signals found. End with a clear, low-friction ask such as "Would a 20-min call make sense?"]

### LinkedIn message (≤150 chars, ready to send)
[Reference one concrete thing — portfolio company, thesis, or recent post — and end with a soft ask]

### Gaps / things to verify

### Sources

### Verdict

Table with two columns — **Question** | **Answer**. Rows:
- Should you pursue?
- Stage fit verdict
- Run a parallel raise?
- Best-case outcome
- Bottom line (one punchy sentence)

---

## Output Format

- Use markdown tables for Firm Snapshot, Key People, Fit Assessment, and Verdict
- Cite sources inline where possible (e.g., "per their 2024 thesis post")
- End with: `Email Subject: VC Match <fund-slug> - <fit-score>` 
            `Suggested save filename: vcmatch-<fund-slug>.md`