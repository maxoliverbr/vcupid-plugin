---
name: vcraise
description: "Generate a fundraising strategy memo from the active startup profile and any existing vcmatch/vclist files. Usage: /vcraise. Reads STARTUP_PROFILE.md and any vcmatch-*.md or vclist.md files in the current directory, then produces a full fundraising strategy: sequencing, milestones, timeline, and this week's next actions. Saves to vcraise.md."
---

# /vcraise — Fundraising Strategy Memo

Synthesize everything known about the startup and its VC pipeline into a full fundraising strategy: current state, raise parameters, sequencing, milestone map, timeline, risk factors, and next actions.

## Invocation

```
/vcraise
```

No argument needed. Reads from the current working directory.

## Execution Steps

### Step 1 — Load All Available Context

Read the following files from the current working directory (load all that exist — do not error if some are missing):

1. `STARTUP_PROFILE.md` — **required**. If missing, stop and tell the user to create it first.
2. `vclist.md` — if exists, use for the fund pipeline and tier breakdown
3. `vcmatch-*.md` — load all vcmatch reports found; use for sequencing and milestone mapping
4. `vcprep-*.md` — if any exist, note which funds are meeting-ready
5. `vcposer-*.md` — if any exist, extract the Poser Score and verdict for each fund

### Step 2 — Produce `vcraise.md`

Write a 7-section fundraising strategy memo. Be honest — this is a strategy document, not a pitch. Acknowledge what's missing, not just what's working.

---

## Section 1: Current State

One paragraph, brutal honesty. Assess:
- What the startup has right now (team, traction, product stage, government relationships, domain access)
- What it's missing that a fundable pre-seed in this sector typically requires (revenue, product, full-time team, signed contracts vs. proposals)
- The single biggest fundraising risk at this moment
- One sentence verdict: "Fundable now at [tier/type of investor], not yet fundable at [tier] without [milestone]."

## Section 2: Raise Parameters

| Parameter | Recommendation | Rationale |
|-----------|---------------|-----------|
| **Target amount** | $[X]M | [Why this number — enough to reach the next fundable milestone, not more] |
| **Instrument** | SAFE / Priced Seed | [Why — SAFE for speed and simplicity at pre-seed; priced if lead demands it] |
| **Valuation cap** | $[X]M–$[X]M | [Based on sector/stage comps — be specific, not a wide range] |
| **Timeline to close** | [X] months | [Realistic based on diligence cycles for this investor type] |
| **Minimum viable close** | $[X]M | [The floor that lets you hit the first milestone without full raise] |

## Section 3: Sequencing Strategy

Answer three questions explicitly:

**Who to approach first**: Name the fund(s) and why — warm path, thesis fit, or anchoring effect. If a vclist.md exists, pull the Tier 1 funds. If vcmatch reports exist, rank by fit score.

**Parallel vs. sequential**: Recommend one. Sequential (one at a time) creates urgency but takes longer. Parallel (multiple simultaneous) closes faster but requires managing multiple diligence tracks. For this raise: [recommendation + rationale based on the startup's current traction and urgency].

**How to create urgency**: What milestone, deadline, or competing interest can be used to compress timelines? (e.g., DOE proposal decision date, design partner LOI deadline, conference demo). Name the specific lever.

## Section 4: Milestone Map

What proof points unlock which tiers of investors. Based on vcmatch reports and vclist tiers if available.

| Milestone | Unlocks | Target date |
|-----------|---------|-------------|
| [Milestone 1 — e.g., design partner LOI signed] | [Tier X funds — names if known] | [Month Year] |
| [Milestone 2 — e.g., MVBP complete] | [Tier X funds] | [Month Year] |
| [Milestone 3 — e.g., first paid contract] | [Series A conversations] | [Month Year] |

**What can be done now** (before any milestones): [Specific outreach, flag-planting calls, warm intro requests that can happen with current traction]

**What must wait**: [Which funds or asks to hold until specific milestones land]

## Section 5: Month-by-Month Timeline

From today ([current month]) through close target. Flag hard dependencies.

| Month | Actions | Dependencies |
|-------|---------|-------------|
| [Month 1] | [First outreach, warm intro requests, flag-plant calls] | Scott Nolan intro · vcintro sent |
| [Month 2] | [Follow-ups, first meetings, diligence requests] | Meeting responses |
| [Month 3] | [Second meetings, term sheet conversations] | [Milestone X] |
| [Month 4] | [Close target] | Full-time transition · design partner LOI |

**Hard dependencies** (if these slip, the timeline slips):
- [Dependency 1]: [What it is and who controls it]
- [Dependency 2]: [What it is and who controls it]

## Section 6: Risk Factors & Contingencies

For each risk: what it is, probability (high/medium/low), and the specific fallback.

If any `vcposer-*.md` files were loaded, add a row for each fund scoring below 60: a Watch List fund in your Tier 1 pipeline is a pipeline risk — slow decisions, possible zombie capital, or follow-only capacity. Flag it with a parallel-track contingency.

| Risk | Probability | Contingency |
|------|-------------|-------------|
| Market downturn / risk-off environment | Medium | Focus on government-backed instruments (SBIR, DOE grants) as bridge; delay equity raise 90 days |
| DOE proposal rejected | Medium | Reframe traction around Project PRISM + design partner; pivot outreach to climate-focused funds |
| Design partner goes cold | Low | Accelerate second design partner conversation; use DOE relationships to find a replacement |
| Key fund passes early | Medium | Don't announce — run parallel tracks; use the pass to pressure-test pitch before next meeting |
| Raise takes longer than [X] months | Medium | Identify bridge options: angels, pre-seed rolling SAFE, SBIR Phase I as runway extension |

## Section 7: This Week — Next 3 Actions

The three most important things to do in the next 7 days. Concrete and specific — not "continue fundraising."

1. **[Action]**: [Exactly what to do, who to contact, what to send] — deadline: [specific day]
2. **[Action]**: [Exactly what to do] — deadline: [specific day]
3. **[Action]**: [Exactly what to do] — deadline: [specific day]

---

## Output Rules

- Section 1 must be honest about what's missing — do not write a cheerleading assessment
- Every fund name in Sections 3–5 must come from vclist.md or vcmatch-*.md if those files exist — do not invent fund names
- The milestone map dates must be consistent with STARTUP_PROFILE.md milestones (e.g., MVBP Q4 2026, full-time Q3 2026)
- This Week actions must be doable in 7 days by the founders with no additional research needed
- After saving, tell the user: "Run `/vcintro vcmatch-<fund>.md` for each Tier 1 fund to generate outreach — then send."
