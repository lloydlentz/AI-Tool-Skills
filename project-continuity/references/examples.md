# Output Examples

Illustrative shapes only; adapt content to the actual project.

## Resume orientation (target: 10–15 lines)

```text
**water-bill-site** — status last updated 2026-09-18 by Claude Code

Objective: static site comparing household water bills to city rate tiers.
State: rate-tier calculator works locally; chart page half-built (`src/chart.js`).
Mechanism: `src/rates.js` loads the reviewed `data/rates.json`; both calculator
and chart use that loader. Add rate data there, preserving the shared calculation.
Last completed: imported 2024–2026 bills into `data/bills.csv` (verified: 31 rows).
Blocked: waiting on 2026 rate schedule PDF from the city.
Next: finish tier-colouring in `src/chart.js`, then deploy preview.

Mismatch: status says `data/bills.csv` is committed, but git shows it modified
(3 new rows, uncommitted). Treating the working tree as current.

What would you like to tackle?
```

## Handoff report

```text
Updated:
- water-bill-site/PROJECT_STATUS.md — Current State, Next Steps, Decisions (+1), Recently Completed (+2)
- water-bill-site/CLAUDE.md — added pointer line to PROJECT_STATUS.md

Captured: chart tier-colouring done; decision to use CSS variables for tier colours;
new blocker (rate PDF). Uncommitted: src/chart.js, data/bills.csv.

Validation: `npm run build` passed; all Next Steps paths exist.
Left unresolved: whether to show 2023 data (asked in Open Questions).

Resume with:
/project-continuity resume water-bill-site
```

## Scope question (multi-project repo, no clear scope)

```text
This repo holds several independent projects. Which should I hand off?
- sabbatical/ (articles)
- jenn_update/
- water-bill-site/
- kia-niro-rescue-triage/
```

## Resume with a missing source

```text
**reference-assistant** — resume and investigate an unanswered policy question

State: replies use a published source bundle; the requested page is absent.
Mechanism: `sources/registry.py` owns URLs; `sources/scan.py` saves snapshots;
`replies/context.py` reads the published bundle. Reviewed publication is required.
Gap: missing source data, not a missing retrieval capability.
Next: prepare the source through the existing registry and scan workflow,
then validate the saved evidence before any separately authorized publication.
```

The file names are illustrative. An actual orientation cites verified project files.
