---
name: vcterm
description: "Analyze a VC term sheet against market norms, flag founder-unfriendly clauses, score founder-friendliness, and produce a ranked negotiation priority list. Usage: /vcterm <termsheet-file.md>. Reads STARTUP_PROFILE.md. Saves to vcterm-<fund>.md."
license: MIT
compatibility: Requires Claude Code with WebSearch and WebFetch. Internet connection required.
allowed-tools: WebSearch WebFetch Read Write
metadata:
  author: 3Flux
  version: "1.0"
  workflow-step: "10 — run when you receive a term sheet"
---

# /vcterm — Term Sheet Analyzer

Benchmark every clause in a VC term sheet against current market norms, flag founder-unfriendly terms, score overall founder-friendliness out of 100, and produce a ranked negotiation priority list with suggested pushback language.

## Invocation

```
/vcterm <termsheet-file.md>
```

Example: `/vcterm termsheet-a16z.md` or `/vcterm a16z-safe.md`

## Execution Steps

### Step 1 — Load Files

Read two files:

1. `STARTUP_PROFILE.md` — extract: company name, stage, raise amount, instrument (SAFE / priced / convertible), sector, founder count, and any existing investor relationships mentioned
2. The term sheet file passed as argument — read the full content

Derive fund slug and output filename:
- Strip a leading `termsheet-` prefix if present
- Strip the `.md` extension
- Lowercase and hyphenate
- Examples: `termsheet-a16z.md` → fund = `a16z`, output = `vcterm-a16z.md`; `sequoia-seed-ts.md` → fund = `sequoia-seed-ts`, output = `vcterm-sequoia-seed-ts.md`

If either file is missing, stop and tell the user which one to provide.

If the term sheet file appears to be blank or contains fewer than 50 words, stop and tell the user: "The term sheet file looks empty or too short to analyze. Paste the full term sheet content into the file and try again."

### Step 2 — Research Market Norms

Run targeted searches to establish the benchmarking baseline for the startup's stage and instrument:

1. Search for current YC SAFE standard terms (post-money SAFE, pro-rata, MFN clause)
2. Search for NVCA model term sheet benchmarks for seed/Series A (board composition, liquidation preference, anti-dilution)
3. Search for current market norms on: founder vesting acceleration, employee option pool sizing, protective provisions veto lists
4. Search for recent (last 12 months) founder-reported term sheet analysis or surveys (e.g., Cooley, Fenwick, or similar law firm annual reports)

Hold these benchmarks as the reference standard for Step 3.

### Step 3 — Clause-by-Clause Analysis

For each of the following term categories, compare the term sheet content to market norms and assign a verdict:

- 🟢 **Market standard or founder-friendly** — no action needed
- 🟡 **Slightly investor-favorable** — worth flagging, may be worth a conversation
- 🔴 **Materially founder-unfriendly** — negotiate before signing

Analyze all applicable categories. Skip categories not present in the term sheet (note as "Not included"):

| Category | What to look for |
|----------|-----------------|
| **Valuation / Cap / Discount** | Cap vs. current comparables; discount rate vs. market (20% is standard for convertibles); MFN clause presence |
| **Liquidation Preference** | 1x non-participating is standard; 2x or participating preferred is a red flag |
| **Anti-Dilution** | Broad-based weighted average is standard; full ratchet is a red flag |
| **Pro-Rata Rights** | Presence and scope; major investor threshold; whether it extends to follow-on rounds |
| **Board Composition** | Founder majority until Series B is standard; any immediate investor board control is a red flag |
| **Founder Vesting & Acceleration** | 4-year / 1-year cliff is standard; acceleration on change of control (single vs. double trigger); vesting credit for time already served |
| **Employee Option Pool** | Size (10–15% pre-money is standard at seed); whether it's pre-money or post-money (pre-money dilutes founders more) |
| **Information Rights** | Standard financial reporting requirements; any unusual access rights or approval requirements |
| **ROFR / Co-Sale / Drag-Along** | Scope and thresholds; drag-along voting requirements; whether drag-along can force a sale founders oppose |
| **Protective Provisions** | List of investor veto rights; standard is 8–12 items; unusual vetoes on operational decisions are red flags |
| **No-Shop / Exclusivity** | Duration (30 days is standard; >45 days is aggressive); whether it prevents talking to other investors |
| **Pay-to-Play** | Whether existing investors must participate in future rounds to maintain rights |

### Step 4 — Score Founder-Friendliness

Calculate the Founder-Friendliness Score (0–100):

- Start at 100
- Deduct **15 points** for each 🔴 clause
- Deduct **5 points** for each 🟡 clause
- Clamp the result to a minimum of 0

Score tiers:
- **85–100 — Founder-Friendly**: Standard or better on most clauses. Sign with standard review.
- **65–84 — Acceptable**: A few investor-favorable terms, but nothing unusual for the market. Negotiate the reds.
- **45–64 — Investor-Favorable**: Multiple aggressive clauses. Push back on all reds and escalate the yellows.
- **0–44 — Aggressive / Founder-Unfriendly**: Significant structural disadvantages. Get a second legal opinion before proceeding.

### Step 5 — Build Negotiation Priority List

For every 🔴 and 🟡 clause, produce a ranked negotiation item. Rank by:
1. Magnitude of founder harm (structural, long-term impact ranks highest)
2. Likelihood of successful pushback (market precedent exists → higher)
3. Strategic importance at this stage

For each item, provide:
- The clause and what's wrong with it
- The market standard to cite
- A specific ask (what language to propose)
- Suggested pushback phrasing (1–2 sentences the founder can say or write)
- Likelihood of success: High / Medium / Low

### Step 6 — Save and Report

Write the full analysis to `vcterm-<fund>.md` using the output format in `references/output-format.md`.

Then tell the user:
- The Founder-Friendliness Score and tier
- How many red and yellow flags were found
- "Share the Negotiation Priority List with your attorney before responding to the fund."
- "Run `/vctrack` to add this fund's term sheet status to your pipeline view."

---

## Output Rules

- Every clause verdict must cite the specific market benchmark it's being compared to — no vague references
- Suggested pushback language must be ready to paste into an email — not a framework, an actual sentence
- The Negotiation Priority List must be ordered by priority rank, not by clause order in the term sheet
- If a clause is not present in the term sheet (e.g., no board composition clause for a SAFE), note it as "Not included — standard for this instrument" and assign 🟢
- Do not offer legal advice — include a disclaimer: "This analysis is for informational purposes only and does not constitute legal advice. Consult your attorney before responding."
- Word budget: ≤2,000 words total across all sections (the clause table may exceed this — that's acceptable)
