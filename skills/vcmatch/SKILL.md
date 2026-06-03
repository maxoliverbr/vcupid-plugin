---
name: vcmatch
description: "Match the active startup profile against a VC fund. Usage: /vcmatch <VC Fund Name>. Reads STARTUP_PROFILE.md, spawns 4 parallel domain research sub-agents, and produces a structured VC Match Report with 8-dimension fit scoring summing to /100, portfolio pattern analysis, deal process intel, and warm intro paths."
license: MIT
compatibility: Requires Claude Code with WebSearch, WebFetch, and Agent. Internet connection required.
allowed-tools: WebSearch WebFetch Read Write Agent
metadata:
  author: 3Flux
  version: "3.0"
  workflow-step: "4 — run after /vcposer scores 60+"
---

# /vcmatch — VC Match Analysis

Match the active startup profile against a VC fund using 4 parallel domain research sub-agents. Produces a 16-section report with an 8-dimension fit score summing to /100, portfolio pattern analysis, deal process intelligence, and warm intro paths.

## Invocation

```
/vcmatch <VC Fund Name>
```

Example: `/vcmatch a16z` or `/vcmatch Y Combinator`

## Execution Steps

Execute these five steps in order.

---

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md` from the current working directory. Extract and hold in context:

- Company name and one-liner
- CEO name and key credentials (3–5 highlights)
- CTO name and key credentials (3–5 highlights)
- Sector / category
- Stage (Idea / MVP / MVBP / Revenue / Growth)
- Geography
- Target customer (specific buyer, not generic)
- Business model
- Traction (exact metrics — numbers, not descriptions)
- Raise amount and instrument (SAFE / priced seed / TBD)
- Known competitors
- Referral contacts (name, email, relationship if listed)

Derive the fund slug: lowercase the fund name, strip punctuation and spaces (`Y Combinator` → `y-combinator`, `a16z` → `a16z`).

If `STARTUP_PROFILE.md` does not exist, stop and tell the user: "Create `STARTUP_PROFILE.md` first — all /vcmatch research is personalized to your startup profile."

---

### Step 2 — Poser Pre-Check

Before spawning any sub-agents, check for `vcposer-<fund-slug>.md` in the current directory.

- **Score < 40:** Stop. Tell the user: "This fund scored [N]/100 on vcposer — likely a poser. Run `/vcposer <fund>` to review the evidence, or move to the next fund."
- **Score 40–59:** Continue, but flag for a warning banner in the final report. Tell the user: "Proceeding with caution — this fund scored [N]/100 on vcposer."
- **Score 60+ or file not found:** Proceed normally.

---

### Step 3 — Spawn 4 Parallel Research Sub-Agents

Read the four agent prompt files from `references/`:
- `skills/vcmatch/references/agent-thesis.md`
- `skills/vcmatch/references/agent-portfolio.md`
- `skills/vcmatch/references/agent-people.md`
- `skills/vcmatch/references/agent-deal.md`

Build a self-contained prompt for each sub-agent by substituting the following placeholders in the agent file text:

| Placeholder | Value |
|-------------|-------|
| `{{FUND_NAME}}` | The fund name as entered by the user |
| `{{FUND_WEBSITE}}` | Best-guess domain (e.g., `a16z.com`) |
| `{{SECTOR}}` | Startup's sector/category from profile |
| `{{ADJACENT_SECTOR}}` | 1–2 closely related sectors |
| `{{STAGE}}` | Startup's current stage |
| `{{GEOGRAPHY}}` | Startup's geography |
| `{{ONE_LINER}}` | Startup's one-liner |
| `{{RAISE_AMOUNT}}` | Raise amount |
| `{{BUSINESS_MODEL}}` | Business model |
| `{{TRACTION}}` | Key traction metrics |
| `{{COMPETITORS}}` | Known competitors |
| `{{COMPETITOR_CATEGORY}}` | Generic competitor category |
| `{{CEO_NAME}}` | CEO name |
| `{{CEO_CREDENTIALS}}` | CEO key credentials |
| `{{CTO_NAME}}` | CTO name |
| `{{CTO_CREDENTIALS}}` | CTO key credentials |
| `{{REFERRAL_CONTACTS}}` | Referral names/orgs from profile |
| `{{REFERRAL_NAME}}` | Primary referral name |
| `{{REFERRAL_ORG}}` | Primary referral organization |
| `{{INSTRUMENT}}` | Raise instrument |

**Fire all 4 Agent tool calls in a single message** so they run in parallel. Each sub-agent must receive a fully self-contained prompt string — sub-agents have no access to the parent conversation context.

Instruct each sub-agent to return only its named field blocks (as defined in the agent file). Sub-agents must not write files, score anything, or make recommendations.

Wait for all 4 sub-agents to complete before proceeding.

---

### Step 4 — Synthesize and Score

Collect the returns from all 4 sub-agents. Reconcile any conflicting data points, noting the source conflict.

**Score the 8 fit dimensions** based on the sub-agent evidence. Each dimension must cite specific evidence — no inflated or uncalibrated scores.

| Dimension | Max Points | Evidence Source |
|-----------|-----------|----------------|
| Sector Fit | 20 | Thesis sub-agent: Sector Clusters, De Facto Focus |
| Stage Fit | 20 | Thesis sub-agent: Stage Focus + Portfolio sub-agent: Entry Stage Reality |
| Thesis Alignment | 20 | Thesis sub-agent: Stated Mandate, De Facto Focus, Thesis Quotes |
| Team-Fund Fit | 10 | People sub-agent: Team-Fund Fit Signals |
| Traction Signal Fit | 10 | Portfolio sub-agent: Traction Bar |
| Check Size / Terms Fit | 10 | Deal sub-agent: Check Size Reality, Instrument Preference |
| Geographic Fit | 5 | Thesis sub-agent: Geography + Deal sub-agent |
| Network / Warm Path | 5 | People sub-agent: Warm Intro Paths, Referral Overlap |

**Overall Fit Score:** Sum of all 8 dimensions. Maximum: 100.

**Recommended Action thresholds:**
- **75–100 → Pursue:** Strong mandate fit, viable path in. Proceed to `/vcintro`.
- **50–74 → Warm Up First:** Good fit signals but missing a proof point or intro. Address the gap, then return.
- **0–49 → No-Go:** Material mandate mismatch or insufficient traction for this fund's bar. Move to the next fund.

---

### Step 5 — Write Output and Report

Read the output template from `references/output-format.md`. Populate all 16 sections using the synthesized evidence and scores from Step 4.

Write the completed report to `vcmatch-<fund-slug>.md`.

The following strings must appear verbatim in the output (downstream skills vcintro, vctrack, and vcdebrief parse them by exact match):
- `Recommended Action:` followed by `Pursue`, `Warm Up First`, or `No-Go`
- `Fit Score:` followed by the numeric score

Then tell the user:
- The Fit Score and Recommended Action
- If **Pursue**: "Run `/vcpartner <fund> <partner name>` to profile the right GP, then `/vcintro vcmatch-<fund>.md` to draft outreach."
- If **Warm Up First**: "The gap is [state the specific dimension with the lowest score]. Address it, then re-run `/vcmatch`."
- If **No-Go**: "This fund is a poor fit — [state the primary reason]. Run `/vclist` to identify better-matched funds."
- "Run `/vctrack` to update your pipeline view."

---

## Output Rules

- Every score in the Fit Assessment must cite specific evidence — not "seems like a good fit"
- The Warm Intro Path section must name specific people or companies — never generic ("ask a portfolio founder")
- The Cold Email must use `[Startup Name]` — never hardcode a company name
- The Verdict table must include a row labeled exactly `Recommended Action`
- If fewer than 3 of the 4 sub-agents return usable data, downgrade the Recommended Action by one tier (Pursue → Warm Up First, Warm Up First → No-Go) and note the data gap
- Word budget: no limit on the full report, but each individual prose section should stay under 200 words; use tables and bullets for density
- Do not fabricate portfolio company names, check sizes, or partner quotes — cite sources or mark as `Unknown`
