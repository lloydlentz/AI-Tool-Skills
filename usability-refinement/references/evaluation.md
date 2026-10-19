# Evaluation and run records

## Grade scale

Use the college-style plus/minus percentage table in [Academic grading in the United States](https://en.wikipedia.org/wiki/Academic_grading_in_the_United_States#Grade_conversion), checked 2026-10-19. That article describes multiple systems; this is the selected convention, not a universal US standard. It supplies the letter conversion, not a usability rubric.

For decimal usability scores, use these continuous lower bounds, without rounding upward to pass a threshold:

| Grade | Score interval |
| --- | --- |
| A+ | 97–100 |
| A | 93–<97 |
| A- | 90–<93 |
| B+ | 87–<90 |
| B | 83–<87 |
| B- | 80–<83 |
| C+ | 77–<80 |
| C | 73–<77 |
| C- | 70–<73 |
| D+ | 67–<70 |
| D | 63–<67 |
| D- | 60–<63 |
| F | 0–<60 |

Normalize Unicode minus to `-`. Reject an unknown grade or a score outside 0–100. B+ requires at least 87; A- requires at least 90. A score of 89.9 remains B+.

## Fixed usability rubric

Score each dimension from 0–100 based on observed behavior, with a short explanation and evidence for deductions. These dimensions and weights are this skill's heuristic, separate from the academic letter scale.

| Dimension | Weight | Evidence to consider |
| --- | --- | --- |
| Task completion and efficiency | 25% | Main tasks can be completed accurately; unnecessary steps, repeated work, lost context. |
| Navigation and information structure | 20% | Clear location, predictable tabs, discoverable actions, sensible grouping and return paths. |
| Readability and visual hierarchy | 15% | Scanability, density, typography, contrast, clear emphasis, usable table labels. |
| Interaction and feedback | 15% | Filters/sorts behave as labeled; loading, empty, error, success and disabled states are understandable. |
| Accessibility and input | 15% | Keyboard access, focus order/visibility, meaningful labels, appropriate semantics and usable controls. |
| Responsive layout and consistency | 10% | Relevant viewport/zoom behavior, clipping, overflow, stable layouts and shared patterns. |

Calibration anchors: 97–100 = exceptional observed execution with negligible friction; 90–96 = clear, efficient execution with minor polish remaining; 80–89 = usable with repeated but recoverable friction; 70–79 = substantial confusion or workarounds; 60–69 = serious difficulty completing important tasks; below 60 = a core task is blocked or unreliable. Apply those anchors to each dimension; do not award points merely because code was changed.

`raw_score = sum(dimension_score * dimension_weight)`.

- A reproducible core-task blocker or keyboard trap caps the affected unit at 59 until verified fixed.
- A major accessibility barrier or a workaround required to complete an important task caps the affected unit at 79 until verified fixed.
- Record the raw score, any cap and its evidence, and the resulting effective score. Cosmetic preference alone never justifies a blocker cap.
- Missing evidence yields **unverified**, not zero or a guessed pass. Non-applicable checks require a reason; redistribute weight only for a genuinely non-applicable dimension established at baseline, consistently across comparisons. An inaccessible tab is unverified, not non-applicable.
- Map the effective score to a letter with the table above. Preserve full precision for threshold checks; one decimal is enough for display, but show more if rounding would misrepresent a boundary.

## Coverage and aggregation

A unit is a tab, shared shell, or major interaction users depend on, such as filtering a portfolio, sorting a table, or navigating a detail dialog. Avoid grading every decorative DOM node. A unit's checks include its relevant viewports and states. Record individual check failures; the unit's score for a scenario is the lowest effective score across its required checks. Do not average away a broken mobile/keyboard state.

Maintain one scorecard row per scenario × unit, with stable IDs. Each row includes applicable checks, baseline/current dimension and effective scores, letter grade, evidence location, top suggestions, and verification status. If any required check is unverified, the row cannot pass. Mark unverified rows as such even when a provisional score is available for observed checks.

For summaries, a tab's displayed grade is its weakest verified scenario/check result, capped further by its child interaction units. If any required child or scenario is unverified, label the tab incomplete. The overall page score is the unweighted mean of tab scores plus the shared-shell score (do not double-count child interactions); it is provisional if any required coverage is missing. Report the weakest unit alongside the overall grade. The stopping test uses **all individual required units/checks**, not the overall average, and requires no unresolved task/accessibility blockers.

Examples:

- One tab scores A, another B+: an A- target is unmet, regardless of the average.
- A tab is A- for one named scenario but B for the other: its reported grade is B.
- All observed tabs score A-, but one tab could not be opened: coverage is incomplete and the target is unverified.
- A visually improved tab retains a keyboard trap: the cap remains until the interaction is verified fixed.
- Preview passes but the live deployment is pending: report the preview outcome and leave the live target unverified.

## Durable records

Follow the repository's record naming conventions. Otherwise use three files in the run's output directory. Keep sensitive raw browser captures outside tracked files unless safe to include.

### `scorecard.md`

Record settings, rubric version/date, scope, branch and environment, scenario aliases, viewport dimensions, coverage inventory, and baseline scores. Append a score table for each completed evaluation with links to evidence. Preserve previous scores rather than replacing the baseline. Each unit retains up to three prioritized remaining suggestions; if none are supported, say so rather than inventing polish work.

### `improvement-log.md`

Record each finding/change with:

- Stable ID, loop, affected unit/scenario, and observed user difficulty.
- Proposed improvement and user benefit; status: planned, implemented, verified, deferred, reverted, or blocked.
- Changed files/components, relevant checks and outcomes, evidence, and any regression/revert.
- Git checkpoint reference and separate push/deployment/live-verification states. Add returned SHAs in subsequent updates; do not create circular self-SHA requirements.

Record judgment calls beside the associated findings: decision ID, alternatives, evidence, constraints, agent recommendation/confidence, selected option, rationale, tradeoff, reversibility, and validation result. Preserve declined recommendations when they explain a consequential choice.

Close each loop with grades, selected next fixes, checkpoint outcome, and a decision to continue or stop. If interrupted, record the unfinished stage so a later session resumes without pretending the loop completed or resetting the budget.

### `executive-summary.md`

Write the executive section for a reader who did not follow the implementation:

1. What was reviewed, the user tasks supported, scenarios covered, environment, target, loops completed, and stopping reason.
2. Before/after overall and per-tab grades, weakest units, and whether **every** required unit reached target. Distinguish expert review from user testing and verified live results from preview-only work.
3. The largest improvements grouped by user benefit, with concrete before/after examples and the level of change (small polish, interaction refinement, or workflow restructuring). Make no invented time-saved or satisfaction claims.
4. Material judgment calls and their tradeoffs; remaining suggestions, blockers, and deferred work in priority order.
5. Validation performed and its limits, plus Git, deployment, and delivery status.

Append the full per-unit score history, detailed improvement list with IDs/files and evidence, decision log, remaining work, and commit references. Avoid duplicating sensitive record data. The Google Doc contains both executive section and detailed appendix. The email contains the concise executive summary and verified document link, not the raw portfolio contents.

Record final document URL and email result locally. Commit/push final reporting updates when the configured checkpoint mode authorizes them. If reporting or delivery fails after UX work is complete, keep those outcomes separate and retain the unfinished obligation for resumption.
