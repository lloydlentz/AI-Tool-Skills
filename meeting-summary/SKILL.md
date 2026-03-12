---
name: meeting-summary
description: Summarize a meeting transcript into an executive summary, issues discussed, and a prioritized to-do list. Use this skill whenever the user uploads or pastes a Zoom transcript, meeting notes, or any meeting recording text and asks for a summary, recap, action items, or follow-ups. Also trigger when the user says things like "we just finished a meeting", "here's the transcript", "summarize this call", or "what do I need to follow up on". Works for internal team meetings, client/consulting calls, and 1-on-1s.
---

# Meeting Summary Skill

Produces a structured post-meeting summary from a transcript, tuned to surface what matters most: the quick executive overview, the key discussion threads, and — most importantly — what needs to happen next.

---

## Configuration

**Default name:** `Lloyd`

This is the name used to identify action items assigned to or owned by the user. If the user provides a different name in their prompt (e.g. "my name is Sarah"), use that instead for that session.

---

## Input

The user will provide one of:
- An uploaded transcript file (Zoom `.txt` or `.vtt`, or similar)
- Pasted transcript text
- A mix of both

If no transcript is provided, ask: *"Could you paste the transcript or upload the file?"*

---

## Output Format

Produce the summary in exactly this structure, in this order:

---

### 📋 Meeting Summary

**[Meeting title or inferred topic] — [Date if available]**

#### Executive Summary
2–3 sentences. Write for someone who wasn't in the meeting and has 20 seconds. Capture: what the meeting was about, the most important outcome or decision, and the overall status/mood (e.g. "concerns remain", "alignment reached", "next steps unclear").

---

#### Issues Discussed
A bullet list of the substantive topics covered. Each bullet should:
- Be 1–2 lines max
- Name the topic clearly
- Note the outcome or status (resolved / open / deferred / in progress)
- Omit small talk, logistics chatter, and filler

Example format:
- **Budget for Q3 campaign** — Discussed $15K ask; not approved, pending finance review
- **Onboarding timeline** — Agreed to push start date to April 1

---

#### ✅ To-Do List

Two subsections:

**My Action Items** *(items assigned to or clearly owned by [configured name])*
- [ ] Action item — with enough context to act on it without re-reading the transcript
- [ ] Include any deadline or next-step context if mentioned

**Other Action Items** *(items assigned to other participants)*
- [ ] [Person's name]: What they committed to
- [ ] [Person's name]: What they committed to

If no owner is clearly stated for an action item, use your best judgment based on context (who raised it, who has relevant role). Note uncertain ownership with *(owner unclear)*.

---

## Behavior Notes

- **Don't over-summarize issues**: If a topic had real depth, give it a real bullet. Don't collapse five distinct concerns into one vague line.
- **Action items should be actionable**: Each to-do should be specific enough that someone could start on it without re-reading the transcript.
- **Infer from context**: Zoom transcripts often have speaker labels (e.g. `Lloyd Lentz: ...`). Use these to attribute action items. If there are no labels, do your best from context.
- **Meeting type awareness**: Adjust tone slightly by context — consulting calls may have client commitments worth surfacing separately; 1-on-1s may be more sensitive; team meetings may have many owners.
- **If the transcript is very short or sparse**: Still produce all three sections, but note if the meeting was informal or inconclusive.

---

## Example Trigger Phrases

- "Here's the Zoom transcript from our call today"
- "Can you summarize this meeting?"
- "What do I need to follow up on from this?"
- "We just finished a call — here's the transcript"
- "[uploads file] meeting recap please"