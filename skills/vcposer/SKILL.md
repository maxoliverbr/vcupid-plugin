---
name: vcposer
description: "Detect VC funds that are posers: zombie funds, stage drifters, thesis cosplayers, and tourist investors who take meetings but don't write checks. Usage: /vcposer <VC Fund Name>. Runs 8 evidence-based checks, scores a Poser Score (0–100), and recommends whether to pursue. Saves to vcposer-<fund>.md."
license: MIT
compatibility: Requires Claude Code with WebSearch and WebFetch. Internet connection required.
allowed-tools: WebSearch WebFetch Read Write
metadata:
  author: 3Flux
  version: "1.0"
  workflow-step: "3 — run before /vcmatch to verify fund legitimacy"
---

# /vcposer — VC Poser Detector

Run a structured 8-check deal flow against a VC fund to determine whether they actually write checks or just show up. Produces a Poser Score and a verdict before founders waste cycles on outreach, vcmatch reports, or meeting prep.

## Invocation

```
/vcposer <VC Fund Name>
```

Examples: `/vcposer a16z` or `/vcposer Slow Ventures`

## Execution Steps

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md` from the current working directory. Extract and hold in context:

- Stage (pre-seed / seed / Series A)
- Sector and category
- Ask amount
- Geography

This context calibrates the checks — a fund that hasn't invested in 12 months is a zombie risk at seed but may simply be between funds at growth stage. Flag relative risk, not just absolute signals.

If `STARTUP_PROFILE.md` does not exist, stop and tell the user to create it first.

Derive the fund slug and output filename: lowercase the fund name, strip spaces and punctuation.
- `a16z` → `vcposer-a16z.md`
- `Slow Ventures` → `vcposer-slow-ventures.md`

### Step 2 — Gather Raw Intel

Use WebSearch and WebFetch across exactly these 6 angles. Run all 6 before moving to Step 3 — do not score until you have the full picture.

1. `"<Fund Name>" new investments portfolio 2023 2024 2025` — investment recency and pace
2. `"<Fund Name>" fund close raised fund II III` — fund lifecycle and vintage
3. `"<Fund Name>" led round lead investor board seat` — deal leadership evidence
4. `"<Fund Name>" partner left departed joined` — team stability and continuity
5. `"<Fund Name>" founder experience feedback ghosted slow` — public founder sentiment
6. `site:<fund-website> portfolio` (or `"<Fund Name>" portfolio companies list`) — actual portfolio for sector/stage analysis

Pull direct quotes and specific dates wherever possible. Named sources beat paraphrases.

**If fewer than 3 of the 6 angles return usable data** (fund is very small, stealth, or new): note this explicitly in the report header and default the verdict to **Watch List**. Do not score what you cannot evidence.

### Step 3 — Run the 8 Poser Checks

Run each check in sequence. For each, produce:
- **Signal:** 🟢 Green / 🟡 Yellow / 🔴 Red
- **Finding:** 1–2 sentences with specifics — dates, numbers, names
- **Evidence:** the source (URL, quote, or named publication)

Signal thresholds are defined per check below.

---

#### Check 1: Fund Vitality (20 pts)
**What it tests:** When did they last make a new investment? Active funds deal every 2–4 months. Silence is a signal.

- 🟢 New deal announced within the last 6 months
- 🟡 Last deal 7–18 months ago — likely between funds or slowing
- 🔴 Last deal >18 months ago, or no deals found at all — zombie risk

**Points:** 🟢 = 20 · 🟡 = 10 · 🔴 = 0

---

#### Check 2: Fund Health (15 pts)
**What it tests:** Is there an active fund with capital to deploy? A fund raising its next vehicle or winding down its last one cannot write new checks.

- 🟢 Recently closed a new fund (within 24 months) and it's not yet fully deployed
- 🟡 Fund close was 3–5 years ago — likely late in deployment, limited dry powder
- 🔴 No fund close found, between funds with no announced raise, or key GPs departed

**Points:** 🟢 = 15 · 🟡 = 8 · 🔴 = 0

---

#### Check 3: Thesis Authenticity (15 pts)
**What it tests:** Does their actual portfolio match their stated sector thesis? Claim to invest in "category-defining" companies without specificity, or show a portfolio scattered across 10 unrelated sectors = thesis cosplay.

- 🟢 ≥60% of observable portfolio matches stated thesis sector and stage
- 🟡 40–59% match — thesis is real but diluted; may be opportunistic
- 🔴 <40% match, or thesis language is too vague to verify against any portfolio company

**Points:** 🟢 = 15 · 🟡 = 8 · 🔴 = 0

---

#### Check 4: Lead vs. Follow (20 pts)
**What it tests:** Have they ever led a round? Follow-only funds cannot anchor a raise. Look for: board seats, "led by" press language, first-check signals in portfolio company announcements.

- 🟢 Clear evidence of leading multiple rounds (board seats, "led by" in announcements)
- 🟡 Evidence of leading 1–2 rounds, or unclear — may be able to lead but doesn't prefer to
- 🔴 No evidence of ever leading a round; appears exclusively co-invest or FOMO follow

**Points:** 🟢 = 20 · 🟡 = 10 · 🔴 = 0

---

#### Check 5: Stage Honesty (10 pts)
**What it tests:** Do their last 10 investments actually match their stated stage focus? Many funds claim "seed" but entry rounds average $8–15M — that's Series A.

- 🟢 Last 5–10 investments are at the fund's stated stage (or one adjacent stage)
- 🟡 1–2 stage drifts visible — may be selective, not systematic
- 🔴 Consistent stage drift of 1+ stages in either direction — bait and switch

**Points:** 🟢 = 10 · 🟡 = 5 · 🔴 = 0

---

#### Check 6: Check Size Reality (10 pts)
**What it tests:** Stated check range vs. observable co-investment data from portfolio company public raises. Funds that consistently come in at the floor of their stated range (or below) are inflating their positioning.

- 🟢 Observable deal sizes align with stated range (within 20%)
- 🟡 Observable deals trend toward the low end of the stated range — modest but credible
- 🔴 Observed checks are consistently below their stated minimum, or no observable data exists to verify a large stated range

**Points:** 🟢 = 10 · 🟡 = 5 · 🔴 = 0

---

#### Check 7: Signal-to-Check Ratio (5 pts)
**What it tests:** Conference appearances, podcast episodes, Twitter/X threads, and blog posts in the last 12 months vs. actual new investment count. High-output, low-check funds are tourists — they're building a brand, not a portfolio.

- 🟢 Content and conference presence is proportionate to investment pace (or investment pace dominates)
- 🟡 Noticeable content-heavy, deal-light imbalance — may be raising a new fund or pivoting thesis
- 🔴 Heavy public presence (frequent keynotes, prolific posting) with fewer than 3 observable new deals in 12 months

**Points:** 🟢 = 5 · 🟡 = 3 · 🔴 = 0

---

#### Check 8: Founder Sentiment (5 pts)
**What it tests:** Public founder feedback on what it's actually like to work with this fund. Search for X/Twitter threads, podcast references, Blind posts, and direct quotes in founder interviews. Patterns of ghosting, slow decisions, or adversarial behavior post-term-sheet are disqualifying signals.

- 🟢 Positive founder references found, or no negative patterns detected
- 🟡 Mixed or thin feedback — insufficient data to flag, but not a ringing endorsement
- 🔴 Documented pattern of ghosting, reneging, or adversarial post-investment behavior

**Points:** 🟢 = 5 · 🟡 = 3 · 🔴 = 0

---

### Step 4 — Score and Verdict

Sum the points across all 8 checks.

**Poser Score: XX/100**

Show the per-check breakdown in a table:

| Check | Signal | Points Earned / Max |
|-------|--------|---------------------|
| 1. Fund Vitality | 🟢/🟡/🔴 | X / 20 |
| 2. Fund Health | 🟢/🟡/🔴 | X / 15 |
| 3. Thesis Authenticity | 🟢/🟡/🔴 | X / 15 |
| 4. Lead vs. Follow | 🟢/🟡/🔴 | X / 20 |
| 5. Stage Honesty | 🟢/🟡/🔴 | X / 10 |
| 6. Check Size Reality | 🟢/🟡/🔴 | X / 10 |
| 7. Signal-to-Check Ratio | 🟢/🟡/🔴 | X / 5 |
| 8. Founder Sentiment | 🟢/🟡/🔴 | X / 5 |
| **Total** | | **XX / 100** |

**Verdict:**

| Score | Verdict | What it means |
|-------|---------|---------------|
| 80–100 | **Legit** | Active fund, real checks, honest mandate — worth pursuing |
| 60–79 | **Probable** | Yellow flags present; prioritize if fit is strong, but clarify open questions |
| 40–59 | **Watch List** | Material poser signals; de-prioritize unless a warm intro already exists |
| 0–39 | **Likely Poser** | Don't waste cycles — redirect to better-fit funds |

### Step 5 — Save and Report

Write the full check report to `vcposer-<fund>.md`.

Then tell the user:
- **Legit (80–100):** "This fund checks out. Run `/vcmatch <fund>` to see if the mandate fits your startup."
- **Probable (60–79):** "Yellow flags noted — run `/vcmatch <fund>` but factor these signals into how hard you chase this one."
- **Watch List (40–59):** "De-prioritize unless you have a warm intro. If you do, run `/vcpartner <fund>` to find the one person who actually moves deals."
- **Likely Poser (0–39):** "Skip this fund. Run `/vclist` to surface better-fit alternatives."

---

## Output Format

When producing the output file, read the exact template from [references/output-format.md](references/output-format.md).

---

## Output Rules

- Every check must cite named evidence — URLs, dates, quotes, or named publications. If evidence is absent, say what was searched and why it came up empty.
- Show the per-check score table before the check details — founders need the summary before the breakdown.
- If a fund has <3 angles with usable data, print this warning at the top of the report: `⚠️ Limited public data — fewer than 3 checks could be fully evidenced. Verdict defaulted to Watch List regardless of score.`
- The Poser Score is not a fit score — it says nothing about mandate alignment. Always clarify this before the recommended action.
- Total word budget for check details: ≤700 words. The score table and verdict rationale are not counted.
- Do not recommend `/vcmatch` until the verdict is Legit or Probable.
