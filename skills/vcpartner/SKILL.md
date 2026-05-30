---
name: vcpartner
description: "Deep profile on a specific VC partner. Usage: /vcpartner <fund> <partner name>. Researches the partner's background, personal thesis, portfolio companies they've led, public writing, and speaking topics. Produces conversation starters and a fit assessment against the active startup profile. Saves to vcpartner-<fund>-<lastname>.md."
---

# /vcpartner — VC Partner Deep Profile

Research a specific VC partner and produce a 7-section brief so the founders know exactly who's in the room before the meeting.

## Invocation

```
/vcpartner <fund> <partner name>
```

Examples:
- `/vcpartner a16z "Erin Price-Wright"`
- `/vcpartner "Lowercarbon Capital" "Clay Dumas"`

## Execution Steps

### Step 1 — Load Startup Context

Read `STARTUP_PROFILE.md` from the current working directory. Extract: company name, sector, solution, team credentials, traction signals, and referral network. This context shapes what to look for in the partner profile — you're not producing a generic bio, you're producing a brief that tells the founders how to connect with this specific person.

If `STARTUP_PROFILE.md` does not exist, stop and tell the user to create it first.

Derive output filename from the inputs:
- Fund: lowercase, strip spaces and punctuation → e.g., `a16z`
- Partner last name: lowercase → e.g., `price-wright`
- Output: `vcpartner-<fund>-<lastname>.md`

### Step 2 — Research the Partner

Run WebSearch and WebFetch across multiple angles. For each, pull direct quotes where possible — quotes are more useful than paraphrases.

**Search queries:**
1. `"[Partner Name]" "[Fund Name]" investment thesis portfolio companies`
2. `"[Partner Name]" site:[fund-website].com` — essays, announcements, team page
3. `"[Partner Name]" interview OR podcast 2024 2025`
4. `"[Partner Name]" twitter OR X OR linkedin` — recent posts and topics
5. `"[Partner Name]" speaking keynote conference 2024 2025`

**Collect:**
- Career history before VC (company, role, for how long)
- Academic background
- Companies they personally led vs. participated in (look for "led by" or "I invested" language in their posts)
- Their stated focus areas — especially anything that diverges from the fund's general mandate
- Quotes about what excites them, what they look for in founders, what they pass on
- Conferences and events they attend or speak at
- Topics they post about frequently on X/LinkedIn

### Step 3 — Produce the Partner Profile

Output `vcpartner-<fund>-<lastname>.md` with exactly these 7 sections:

---

## Partner Profile: [Partner Name] — [Fund Name]
_For: [Startup Name] | Generated: [date]_

### 1. Background
Career path from pre-VC to today. Education. What they did before joining the fund and for how long. Any operating or technical experience (this matters — operators ask different questions than career VCs).

### 2. Personal Thesis
What they personally care about investing in — distinct from the fund's general mandate where possible. Use direct quotes. Flag if their personal thesis has evolved recently (recent essays or posts often reveal this).

### 3. Deals They've Led
Table or list of companies they personally championed (not just participated in). For each: company name, sector, stage at investment, what they've said publicly about why they backed it. This reveals their pattern — what problems excite them, what founder profiles they back.

| Company | Sector | Stage | Why they backed it (quote or summary) |
|---------|--------|-------|---------------------------------------|

### 4. Public Writing & Key Quotes
Specific essays, posts, or interview clips — with titles, links if found, and the 1–2 sentences most relevant to the startup. Do not summarize generically. Extract the sentence that would make a founder think "she's talking about us."

### 5. Personal Touchpoints
- Conferences they speak at or attend
- Topics they post about on X/LinkedIn (with rough frequency)
- Communities or working groups they're part of
- Any shared background with the founding team (geography, alma mater, prior company, DOE/government work, etc.)

### 6. Fit Assessment
How this specific partner maps to the startup — not the fund generically. Address:
- **Problem resonance**: does their stated focus align with this specific problem?
- **Team resonance**: does their background create natural credibility or connection with the founders?
- **Thesis hook**: which element of the startup would most excite them personally (based on their deals and writing)?
- **Risk**: what would make them personally skeptical — based on their pattern, not the fund's general red flags?

### 7. Conversation Starters
Three specific, non-generic things to bring up in the meeting. Each must be grounded in something the partner actually wrote, said, or did — not a generic compliment.

1. **[Topic]**: "[Verbatim quote or specific reference]" — open with this because it shows you read their work, not just the fund's website.
2. **[Topic]**: Reference to a specific portfolio company they led — ask how they think about [relevant parallel to your startup].
3. **[Topic]**: A specific question that invites them to share their personal view, not the fund's official line.

---

## Output Rules

- Every section must be grounded in research — do not fill gaps with generic VC partner stereotypes
- Quotes must be real and sourced (note where you found them)
- The Fit Assessment must reference the startup specifically — not just "this fund invests in energy"
- Conversation Starters must be specific enough that a generic startup couldn't use them
- If research on the partner is thin (e.g., low public profile), say so explicitly and note what could not be verified
