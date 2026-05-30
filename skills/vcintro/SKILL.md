---
name: vcintro
description: "Draft VC outreach from a vcmatch report. Usage: /vcintro <vcmatch-report.md>. Reads STARTUP_PROFILE.md and the vcmatch report, then produces three outreach variants: cold email, warm intro request, and LinkedIn DM. Saves to vcintro-<fund>.md."
---

# /vcintro — VC Outreach Drafter

Draft three fund-specific outreach variants from a vcmatch report: a cold email, a warm intro request, and a LinkedIn DM.

## Invocation

```
/vcintro <vcmatch-report.md>
```

Example: `/vcintro vcmatch-a16z.md`

## Execution Steps

### Step 1 — Load Context

Read two files:

1. `STARTUP_PROFILE.md` — extract: company name, one-liner, founder names, referral contact (name + email if listed), website, ask amount
2. The vcmatch report passed as argument — extract:
   - Fund name and target partner name
   - Opening hook (verbatim from "Optimal Pitch Angle" section)
   - Fit score
   - Recommended action (Pursue / Warm Up First / No-Go)
   - Top 1–2 traction proof points most relevant to this fund
   - Referral name if mentioned in the vcmatch

Derive fund slug and output filename: `vcmatch-a16z.md` → fund = `a16z`, output = `vcintro-a16z.md`

If the recommended action is **No-Go**, stop and tell the user: "The vcmatch recommends No-Go for this fund. Outreach is not advised — run `/vcmatch` on a better-fit fund first."

If either file is missing, stop and tell the user which one to provide.

### Step 2 — Draft Three Outreach Variants

Produce all three variants. Every variant must use the fund-specific opening hook from the vcmatch report — never a generic opener.

---

#### Variant A — Cold Email

Direct to the target partner. Peer-to-peer tone. No fluff, no supplication.

Rules:
- Subject line: ≤8 words, references their thesis or a specific portfolio company — not the startup's name
- Body: 4 sentences maximum
  1. Opening hook (verbatim from vcmatch, adapted for email)
  2. One traction proof point — the most credible one for this fund
  3. One-line on who we are and why now
  4. Ask: specific (15-minute call), with a concrete hook ("happy to share the DOE brief")
- Sign-off: founder name, title, company, website — no pitch deck link unless fit score is ≥75

Format:
```
Subject: [subject line]

[Body — 4 sentences]

[Founder Name]
[Title], [Company]
[Website]
```

---

#### Variant B — Warm Intro Request

Written as a note FROM the founder TO the referral contact (e.g., Scott Nolan), asking them to forward it to the target partner. The referral should be able to copy-paste the forwarding note with minimal editing.

Rules:
- First paragraph (to the referral): 2 sentences — ask for the intro, state why this fund specifically
- Second paragraph (the forwardable note): 3–4 sentences — hook, traction, ask. This is what gets forwarded.
- Close: thank them, offer to send more context if needed

Format:
```
[Referral first name],

[Ask for intro — 2 sentences]

Here's a note you can forward directly:

---
[Target Partner first name],

[Forwardable note — 3–4 sentences using the vcmatch hook]

[Founder Name]
[Title], [Company]
[Website]
---

Thanks [Referral first name] — let me know if you'd like the full vcmatch brief first.

[Founder Name]
```

---

#### Variant C — LinkedIn DM

Direct to the target partner. 3 sentences maximum. No deck link. No attachment.

Rules:
- Sentence 1: Fund-specific hook — reference something they wrote or invested in
- Sentence 2: One-line on what 3FLUX does and the strongest proof point
- Sentence 3: Specific ask — a call, a reply, a coffee — with a time hook ("15 minutes this month?")

Format:
```
[Body — 3 sentences]
```

---

### Step 3 — Save and Report

Write all three variants to `vcintro-<fund>.md`.

Then tell the user:
- **Use Variant A (cold email)** if no warm path exists
- **Use Variant B (warm intro)** if the referral contact is named in the vcmatch or STARTUP_PROFILE.md — this is always the preferred path
- **Use Variant C (LinkedIn DM)** if the target partner is active on LinkedIn/X and responds to DMs (check their recent posting activity)

Also tell the user: "Run `/vcprep vcmatch-<fund>.md` before the call so you're ready when they respond."

---

## Output Rules

- The opening hook must come verbatim from the vcmatch "Optimal Pitch Angle" — do not invent a new one
- Every variant must name the target partner specifically — never "Dear VC" or "To Whom It May Concern"
- The cold email body is 4 sentences maximum — if it's longer, cut it
- The LinkedIn DM is 3 sentences maximum — non-negotiable
- Tone throughout: founder-to-peer, not founder-to-gatekeeper. Confidence, not desperation.
- If fit score is below 50, add a warning at the top of the output: "⚠️ Fit score is [X]/100 — review the vcmatch red flags before sending."
