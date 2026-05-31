---
name: vcperks
description: "Research the full value a VC fund delivers beyond the check — credits, services, brand signal, strategic expertise, media amplification, policy access, and follow-on capital pathway — scored by relevance to the active startup. Usage: /vcperks <VC Fund Name>. Saves to vcperks-<fund>.md."
---

# /vcperks — VC Fund Perks Researcher

Research everything a VC fund delivers beyond the check. Produces a two-part perks report: **Part A — Financial Value** (credits, discounts, services with dollar estimates) and **Part B — Non-Financial Value** (brand signal, strategic expertise, media reach, policy access, follow-on pathway). Both parts are scored by relevance to the active startup.

Use this after `/vcmatch` to evaluate competing term sheets on total value — not just valuation and check size.

## Invocation

```
/vcperks <VC Fund Name>
```

Examples: `/vcperks a16z` or `/vcperks "First Round Capital"`

## Execution Steps

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md` from the current working directory. Extract and hold in context:

- Stage (pre-seed / seed / Series A) — determines which perks are usable now vs. later
- Sector and product category — determines brand signal value with specific customer types
- Team size and composition — determines recruiting, HR, and legal urgency
- Business model and GTM — determines whether media amplification or direct sales network matters more
- Operational risks (Risks section) — highlights where non-financial support is highest-leverage
- Ideal investor attributes (if listed) — reveals what the founder already knows they need

If `STARTUP_PROFILE.md` does not exist, stop and tell the user to create it first.

Derive fund slug and output filename: lowercase the fund name, strip spaces and punctuation.
- `a16z` → `vcperks-a16z.md`
- `First Round Capital` → `vcperks-first-round-capital.md`

---

### Step 2A — Research Financial Perks

Use WebSearch and WebFetch across these 5 angles. Run all 5 before scoring.

1. `"<Fund Name>" portfolio benefits perks program startups founders`
2. `"<Fund Name>" cloud credits AWS GCP Azure portfolio companies`
3. `"<Fund Name>" platform team portfolio support services resources`
4. `"<Fund Name>" legal recruiting HR office space founder resources`
5. `site:<fund-website> portfolio resources` or `site:<fund-website> platform` or `site:<fund-website> perks`

**Collect:** Named programs with their specific contents, credit amounts and vendor partners (AWS Activate, Google for Startups, Stripe, Twilio, etc.), service partners for legal/accounting/recruiting/HR, formal programs with structure and eligibility.

---

### Step 2B — Research Non-Financial Value

Use WebSearch and WebFetch across these 4 additional angles.

6. `"<Fund Name>" brand signal reputation enterprise customers portfolio company`
7. `"<Fund Name>" GP partner expertise background sector operating experience`
8. `"<Fund Name>" follow-on pro rata reserve capital bridge portfolio`
9. `"<Fund Name>" content publishing blog newsletter media founders amplification`
10. `"<Fund Name>" policy regulatory government relations team`

**Collect:**
- Evidence of the fund's brand opening doors with enterprise customers or future investors (founder quotes, case studies, press coverage patterns)
- GP and operating partner backgrounds relevant to the startup's sector — named individuals, prior operating roles, comparable investments they've led
- Follow-on fund structure: does the fund have dedicated follow-on reserves? What is their pro rata track record? Do they lead Series A or just participate?
- Content distribution reach: blog subscribers, newsletter size, podcast listeners, social following — and whether portfolio companies get publishing access
- Policy and regulatory team: named staff, government relationships, compliance programs

**Source labeling:** Mark each item as **[Confirmed]** (fund materials or official announcements) or **[Reported]** (founder accounts, secondary sources, community posts).

**If fewer than 3 angles across both research steps return usable data:** state this at the top of the report and add: "Ask the fund directly for their current portfolio benefits guide and platform overview — most funds maintain one but don't publish everything publicly."

---

### Step 3 — Categorize and Score

Organize findings into two parts.

#### Part A — Financial Value

Use a dollar-value estimate and relevance rating for each item.

**Relevance:** High = directly addresses a named gap or need in the startup profile | Medium = useful but not urgent | Low = generic or not stage-appropriate

**7 Categories:**

1. **Cloud & Infrastructure** — AWS/GCP/Azure credits, database tools, dev tooling, API platform credits (Twilio, Stripe, Sendgrid)
2. **Legal & Finance** — discounted outside counsel, accounting, cap table management (Carta, Pulley), banking relationships
3. **Talent & Recruiting** — job board access, ATS discounts, executive recruiting relationships, HR platforms (Rippling, Gusto, Deel)
4. **Go-to-Market** — PR/comms support, analyst relations, CRM discounts (HubSpot, Salesforce), marketing tools, sales enablement platforms
5. **Network & Introductions** — portfolio company intro process, LP relationships, co-investor warm paths, corporate partner introductions, customer introductions from within the portfolio
6. **Operational Support** — office space or co-working access, events, founder summits, peer learning groups
7. **Formal Programs** — structured accelerator-style programs, residencies, office hours tracks, mentorship matching

---

#### Part B — Non-Financial Value

Use an impact rating (High / Medium / Low) and a brief assessment for each dimension. No dollar value — these are qualitative but often the highest-leverage benefits at seed stage.

**5 Dimensions:**

**8. Brand & Signal Value**
What the fund's name on the cap table does for the startup independent of capital:
- **Customer credibility:** Do enterprise buyers move faster when they see this fund's name? Especially relevant for B2B and regulated sectors.
- **Talent attraction:** Does backing from this fund improve candidate acceptance rates for key hires?
- **Future investor signal:** Does this fund's participation accelerate Series A term sheets from other funds? Is the fund a "pedigree" signal in this sector?
- **Ecosystem positioning:** Does the brand association open conference speaking slots, press coverage, or partnership conversations that would otherwise be inaccessible?

Research: look for evidence in founder interviews, portfolio company press patterns, and industry reputation signals specific to the startup's sector.

**9. Strategic Guidance & Pattern Recognition**
The depth and relevance of the knowledge the fund brings to the board table:
- **Comparable investments:** How many companies has this fund backed in the same sector or with the same business model? What did they learn?
- **Named GP/partner expertise:** Who specifically will sit on or observe the board? What is their operating background? Have they built companies in this space?
- **Operating partners and EIRs:** Are there dedicated operating partners with relevant domain expertise (e.g., healthcare, fintech, enterprise SaaS)?
- **Peer founder access:** Can they connect the founders to other portfolio founders who have solved the same problems?

Rate the depth of strategic value as: **Deep** (named GP with directly comparable operating background) / **Relevant** (strong general expertise, some sector knowledge) / **General** (experienced investors without specific domain depth).

**10. Content & Media Amplification**
The fund's ability to accelerate the startup's narrative and market presence:
- **Publishing access:** Can portfolio companies publish on the fund's blog, newsletter, or podcast? What is the distribution size?
- **Social amplification:** Will partners actively amplify launch announcements, hiring posts, and funding news to their own audiences?
- **Event speaking:** Do portfolio companies get invited to speak at the fund's events, summits, or conferences?
- **Research inclusion:** Does the fund produce sector research reports that could include or feature the startup?

Rate reach as: **Large** (100K+ newsletter subscribers or social reach) / **Medium** (10K–100K) / **Small** (<10K or not documented).

**11. Policy & Regulatory Access**
Particularly relevant for startups in regulated sectors (healthcare, fintech, defense, energy):
- **In-house policy team:** Does the fund have dedicated policy or government relations staff?
- **Regulatory navigation:** Can they provide guidance or introductions for compliance, licensing, or government procurement?
- **Government relationships:** Do they have established relationships with relevant agencies (CMS, ONC, CFPB, DOE, DOD, etc.)?

Rate as: **Active** (named staff, documented government relationships) / **Passive** (connections available on request) / **Not available**.

**12. Follow-on Capital Pathway**
The fund's ability and appetite to continue backing the startup beyond the current round:
- **Pro rata rights:** Does the fund typically take pro rata in future rounds? Do they exercise it?
- **Internal follow-on reserves:** Does the fund maintain a reserve pool specifically for follow-on investments?
- **Bridge capacity:** Will they provide bridge capital if a subsequent round takes longer than planned?
- **Series A relationships:** Do they actively co-invest with or introduce the startup to Series A funds? Name the co-investors they commonly syndicate with.
- **Fund lifecycle:** What vintage is the current fund? How many years of investment period remain? A fund in year 7 of a 10-year life may have limited follow-on appetite.

Rate as: **Strong** (documented pro rata exercise, named follow-on fund, known bridge appetite) / **Moderate** (general pro rata rights, co-investor network available) / **Unclear** (not documented — ask directly).

---

### Step 4 — Produce the Perks Report

Write `vcperks-<fund>.md` using this exact structure.

---

## Output Format

```markdown
# Fund Perks: [Fund Name]
_For: [Startup Name] | Generated: [date] | Stage: [stage]_

---

## Estimated Financial Perks Value: ~$[X]K–$[X]K
_(Confirmed credits only. Estimates labeled with ~. Reported perks labeled separately.)_

---

## Top Picks for [Startup Name]
The highest-value items across both financial and non-financial categories — grounded in the startup profile. May include non-financial perks if they outweigh credits for this startup.

1. **[Perk or dimension]** — [value or impact rating] — [1 sentence on why it's the highest-leverage perk for this specific startup]
2. **[Perk or dimension]** — [value or impact rating] — [why]
3. **[Perk or dimension]** — [value or impact rating] — [why]

---

## Part A — Financial Value

### Cloud & Infrastructure
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

### Legal & Finance
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

### Talent & Recruiting
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

### Go-to-Market
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

### Network & Introductions
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

### Operational Support
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

### Formal Programs
| Perk | Status | Est. Value | How to Access | Relevance |
|------|--------|-----------|---------------|-----------|

---

## Part B — Non-Financial Value

### Brand & Signal Value
**Impact for [Startup Name]:** High / Medium / Low
**Customer credibility:** [Evidence — does this fund's brand open doors with the startup's specific buyer type?]
**Talent attraction:** [Evidence — does this fund's name improve candidate close rates?]
**Future investor signal:** [Evidence — does this fund's participation accelerate Series A conversations?]
**Ecosystem positioning:** [Evidence — conferences, press, partnerships]

### Strategic Guidance & Pattern Recognition
**Depth:** Deep / Relevant / General
**Comparable investments:** [How many and which portfolio companies are closest comps to this startup?]
**Who sits at the table:** [Named GP or partner who would take board or observer seat — their operating background and relevant experience]
**Operating partners:** [Named individuals with domain expertise relevant to this startup's sector]
**Peer founder access:** [Evidence of active introductions between portfolio founders]

### Content & Media Amplification
**Reach:** Large / Medium / Small
**Publishing access:** [Blog, newsletter, podcast — distribution size if known]
**Social amplification:** [Evidence of partners amplifying portfolio company news — and whether this matters for the startup's GTM]
**Event speaking:** [Named events, summits, conferences where portfolio companies get slots]
**Relevance for [Startup Name]:** [1 sentence — is this fund's media reach aligned with the startup's buyer persona?]

### Policy & Regulatory Access
**Status:** Active / Passive / Not available
**In-house team:** [Named staff and their backgrounds]
**Regulatory relevance:** [Specific agencies or compliance areas relevant to this startup's sector]
**Government relationships:** [Evidence of relevant agency access]
**Relevance for [Startup Name]:** [1 sentence — does this startup face regulatory or compliance risk where this matters?]

### Follow-on Capital Pathway
**Rating:** Strong / Moderate / Unclear
**Pro rata:** [Does the fund take and exercise pro rata rights?]
**Follow-on reserves:** [Evidence of a dedicated reserve pool or follow-on fund]
**Bridge appetite:** [Known or reported willingness to bridge between rounds]
**Series A syndication:** [Named co-investors this fund commonly brings in for Series A]
**Fund lifecycle:** [Estimated years remaining in investment period — affects follow-on appetite]

---

## Gaps
What peer funds at this stage commonly offer that [Fund Name] does not appear to provide:
- [Gap 1 — name the peer fund setting the benchmark]
- [Gap 2]

---

## Questions to Ask the Fund Directly
Things that could not be confirmed from public sources but matter for the decision:
- [Question 1]
- [Question 2]
- [Question 3]

---

## Sources
- [URL or named source for each confirmed item]
```

---

### Step 5 — Save and Route

Write the full report to `vcperks-<fund>.md`.

Then tell the user:
- "Financial credits are real dilution avoided — but for most seed-stage companies, the non-financial value (brand signal, strategic depth, follow-on pathway) is worth more over a 5-year relationship. Weight both."
- "Run `/vcprep vcmatch-<fund>.md` next — the prep will incorporate your Top Picks into the 'why this fund' talking points for the meeting."
- "The 'Questions to Ask the Fund Directly' section is your due diligence checklist — ask these before countersigning."

---

## Output Rules

**Financial perks:**
- **[Confirmed]** vs. **[Reported]** labels are mandatory for every row — do not omit
- Estimated values must include `~` prefix unless the exact figure is sourced from fund materials
- If a category has no found perks, write: "[Category]: No documented perks found — verified against [sources searched]."

**Non-financial value:**
- Every dimension must be assessed — write "Not documented — ask directly" rather than skipping a section
- Impact ratings (High/Medium/Low for brand; Deep/Relevant/General for strategic; Large/Medium/Small for media; Active/Passive/Not Available for policy; Strong/Moderate/Unclear for follow-on) are mandatory
- Named individuals are required for Strategic Guidance — do not write "experienced partners" without naming them
- The brand signal assessment must reference the startup's specific buyer type (e.g., "healthcare CFOs" not generic "enterprise buyers")
- Follow-on fund lifecycle assessment is mandatory — a fund in year 8 of a 10-year life is a structural risk regardless of stated appetite

**Top Picks:**
- Must draw from both Part A and Part B — non-financial picks are valid and often more important
- Must reference something specific from `STARTUP_PROFILE.md` — never generic
- ≤150 words total

**Gaps & Questions sections:**
- Gaps must name a specific peer fund as the benchmark
- Questions section must include at least 3 specific, unanswered questions from the research — things that genuinely could not be confirmed publicly
