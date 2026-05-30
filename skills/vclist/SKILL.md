---
name: vclist
description: "Build a prioritized VC target list from the active startup profile. Usage: /vclist. Reads STARTUP_PROFILE.md, researches the VC landscape, and produces a tiered list of 15–20 funds ranked by fit with rationale and suggested contact angle. Saves to vclist.md."
---

# /vclist — VC Target List Builder

Research the VC landscape and produce a ranked fundraising pipeline of 15–20 funds tiered by fit with the active startup profile.

## Invocation

```
/vclist
```

No argument needed — reads `STARTUP_PROFILE.md` from the current working directory.

## Execution Steps

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md`. Extract and hold in context:

- Sector and category (deep tech, energy, AI, infrastructure, etc.)
- Stage (pre-seed / seed / Series A) and funding ask size
- Business model (SaaS, value-based, marketplace, etc.)
- Geography (US, specific state, remote)
- Traction signals (revenue, government partnerships, design partners, DOE/grants)
- Team credentials (ex-Google, ex-government, domain PhDs, regulatory access)
- Referral network (any named advisors, investors, or warm contacts in the profile)

If `STARTUP_PROFILE.md` does not exist, stop and tell the user to create it first.

### Step 2 — Research the VC Landscape

Use WebSearch (and WebFetch on fund websites) to identify funds that match. Run searches across multiple angles:

1. Funds by sector thesis: `VC fund "energy grid" OR "power infrastructure" OR "deep tech" seed 2024 2025`
2. Funds by stage: `pre-seed seed fund "climate tech" OR "AI infrastructure" check size 2025`
3. Funds with comparable portfolio: `VC invested "digital twin" OR "grid software" OR "interconnection" startup`
4. Funds aligned to team background: `VC fund "DOE" OR "government" OR "defense" deep tech founders`
5. Funds with national interest / American Dynamism thesis: `VC "national interest" OR "American Dynamism" energy manufacturing`

For each promising fund found, quickly verify:
- Stage and check size match
- Recent investment activity (last 18 months)
- No obvious portfolio conflict
- Named partner with relevant focus

### Step 3 — Score and Tier Each Fund

Rank funds across five dimensions:
1. **Thesis alignment** — does their mandate explicitly match the startup's sector?
2. **Stage fit** — are they writing checks at this stage right now?
3. **Portfolio comps** — have they backed comparable companies?
4. **Warm path** — is there a referral or mutual connection available?
5. **Check size match** — does their typical check match the raise amount?

### Step 4 — Produce `vclist.md`

Write the output to `vclist.md` in the current working directory using this structure:

---

```markdown
# VC Target List: [Startup Name]
_Generated: [date] | Stage: [stage] | Ask: $[amount]_

---

## Tier 1 — Pursue Now
*Strong thesis fit + correct stage. Reach out within 2 weeks.*

### [Fund Name]
- **Why**: [2–3 bullets — specific thesis match, portfolio comp, or team alignment]
- **Target partner**: [Name] — [one-line on why them]
- **Contact angle**: [cold email / warm intro via [Name] / conference / LinkedIn]
- **Run /vcmatch first**: Yes / Already done (link if exists)

[Repeat for 5–7 funds]

---

## Tier 2 — Warm Up First
*Good fit but missing a proof point or warm intro. Plant the flag now; pitch after [milestone].*

### [Fund Name]
- **Why**: [2–3 bullets]
- **Target partner**: [Name]
- **Contact angle**: [angle]
- **What to wait for**: [specific milestone before pitching]

[Repeat for 5–7 funds]

---

## Tier 3 — Monitor
*Interesting but stage mismatch, thesis gap, or unclear path. Revisit in [timeframe].*

### [Fund Name]
- **Why eventually**: [1–2 bullets]
- **Blocker**: [what would need to change]
- **Revisit when**: [milestone or date]

[Repeat for 3–5 funds]

---

## Pipeline Summary
- Total funds identified: [N]
- Tier 1 (pursue now): [N]
- Tier 2 (warm up): [N]
- Tier 3 (monitor): [N]
- Suggested first outreach order: [Fund 1] → [Fund 2] → [Fund 3]
- Warm intro paths available: [list names and who connects them]
```

---

## Output Rules

- Every fund must include a named partner to target — not just the firm
- Cite the source of thesis/portfolio information inline (e.g., "per their 2024 climate thesis post")
- Do not include funds with obvious stage mismatches (e.g., growth-only funds for a pre-seed raise) unless there is a specific strategic reason noted
- Warm intro paths take priority in the suggested outreach order — always surface them
- Flag if any Tier 1 fund has a `/vcmatch` report already saved in the current directory
