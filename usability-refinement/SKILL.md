---
name: usability-refinement
description: Review a live web interface, grade each tab and major interaction, and iteratively improve usability with independent subagents, bounded loops, decision logs, and an executive report. Use for usability refinement or a graded UX improvement cycle.
---

# Usability refinement

Improve an existing interface through observed browser behavior, focused implementation, and independent re-evaluation. Preserve the product's purpose, data semantics, and useful workflows. Grades are evidence-backed expert heuristics, not measured user-study results.

## Configure the run

Interpret natural-language options or `key=value` arguments. Apply explicit user settings first, then these defaults. State the resolved settings and start; ask only for essential information that cannot be discovered.

| Setting | Default | Meaning |
| --- | --- | --- |
| `mode` | `refine` | `refine` implements improvements; `audit` only reviews and reports. |
| `max_loops` | `4` | Positive integer; maximum implementation/re-evaluation cycles. Baseline is loop 0 and does not consume a cycle. |
| `target_grade` | `A-` | Minimum grade for **every** in-scope tab and major interaction in every required scenario. Accept A+ through F from the rubric. |
| `scope` | Current/requested page, all tabs | Include shared navigation, filters, tables, dialogs, and key workflows. Explicit exclusions remain excluded. |
| `scenarios` | User-named people/roles/records | Inspect each named scenario separately. Otherwise discover representative populated and sparse states without expanding access. |
| `viewports` | Desktop and narrow/mobile | Record actual dimensions; honor a stated desktop-only product constraint. |
| `checkpoint` | `commit-and-push` | Frequent coherent commits, with a complete checkpoint and push at least once per completed refinement loop. Options: `commit-only`, `none`. |
| `delivery` | `google-doc-and-email` | Executive summary and detailed appendix in a Google Doc, emailed to the user. Options: `google-doc`, `local`. Always keep a local report. |
| `recipient` | Verified current user | Resolve from authenticated account context or a previously supplied address. Never infer an address from a name. |
| `output_dir` | Owning area's tracked work directory | Follow repository conventions; otherwise use `work/usability/<date>-<slug>/`. Resume an existing run only when requested. |

An **explicit invocation** of this full workflow requests its default Git checkpoints, Google Doc, and summary email to the verified user, unless overridden. Do not re-ask for permission already granted. When this skill is selected implicitly for a general UX request, honor the actual request: enable push, document publication, or email only when authorized; otherwise use local reporting and authorized Git actions. A request to review and give suggestions resolves to `mode=audit`, including when the skill is selected implicitly. An audit request never authorizes implementation or deployment. Login access alone does not authorize changing production. Creating or editing this skill does not start a usability run.

For a live refinement request that already authorizes deployment, carry it out within the stated scope. Otherwise prepare and verify the implementation in an available preview, and request any necessary deployment approval only when the exact changes are ready for review. A required answer never becomes approval through elapsed time.

Read [the grading and reporting reference](references/evaluation.md) before scoring. Freeze the rubric and coverage inventory for the run; document additions rather than dropping difficult areas to reach the target. Validate settings before making changes. If the user says “B+ or A-” without choosing, state that A- is the chosen threshold; honor an explicit B+ setting.

## Establish the baseline

1. Read applicable `AGENTS.md` files and relevant project instructions. Inspect Git status, branch, remotes, and existing work; preserve unrelated edits and staged files. Identify the source files and actual deployment path for the page.
2. Discover the requested browser/session using available browser tools. Reuse the authenticated session when accessible; verify access instead of assuming Chrome and another browser share cookies. If access is unavailable, continue source review and preparation, but mark browser grades unverified and request only the missing access.
3. Inventory every tab, shared shell, and major interaction before editing. Assign stable unit IDs. Build the scenario × unit coverage matrix, including relevant viewports and states. Verify record identity when names are ambiguous; never silently substitute a different person.
4. Observe realistic tasks in the browser: finding information, navigating tabs, searching/filtering/sorting, reading dense tables, understanding empty states, opening/closing dialogs, and returning to previous context. Check keyboard navigation, focus, labels, loading/error feedback, responsive layout, and console/network failures where relevant. Avoid submitting real business transactions merely to test the UI; use an authorized test record or stop before submission and record the limit.
5. Capture enough screenshots, interaction observations, and reproducible steps to support each grade and finding. Keep credentials and sensitive record contents out of tracked evidence and reports; use scenario aliases and redacted evidence where appropriate.
6. Produce baseline scores for every unit and scenario, an overall page grade, the weakest unit, and up to three useful suggestions per unit. Link each suggestion to an observed problem, expected user benefit, and verification step. If baseline already meets the stop criteria, finish with zero refinement loops.

## Use subagents with distinct responsibilities

Use available subagents for this workflow; do not create separate user-owned chats. The coordinator owns scope, integration, deployment, Git, and delivery.

- **Reviewer:** Independently inspect the browser or coordinator-provided evidence and return scores, findings, and suggestions using the fixed rubric. State whether observations were direct or supplied. Prefer a fresh reviewer for each post-change evaluation. Give it the rubric and tasks without the implementer's expected grades or pressure to reach the target; compare to the target after scoring.
- **Implementer:** Make a coherent set of improvements with explicit file ownership. Multiple implementers may work in parallel only on disjoint files. Do not let multiple agents navigate the same shared browser tab or edit the same file concurrently; have the coordinator gather evidence or assign separate tabs.
- **Judgment agent:** For contested design choices, conflicting findings, or meaningful tradeoffs, provide the user task, observations, alternatives, constraints, reversibility, and acceptance criteria. Ask for a recommendation, rationale, costs, confidence, and a way to validate it. Use an available good-judgment skill if it actually fits; otherwise this separate agent fills that role without an additional dependency.

The judgment agent resolves ordinary design choices; it cannot grant permissions or invent business policy. The coordinator records the choice and proceeds within scope. Ask the user only when the decision depends on unavailable policy, essential preferences, or new authorization; continue independent work meanwhile. If subagents are unavailable, disclose the limitation and use separate review and implementation passes without claiming independence.

## Execute each refinement loop

Repeat at most `max_loops` times:

1. **Select:** Prioritize observed task blockers, accessibility barriers, confusing navigation, and below-target units before decorative polish. Record the selected findings and intended benefits. Resolve material judgment calls as above.
2. **Refine:** Make focused source changes, preserving established design patterns and data meaning. Commit coherent verified milestones when useful. Keep the improvement log current, including attempted, reverted, deferred, and completed work.
3. **Verify:** Run checks appropriate to the changed behavior. Re-test affected tasks and shared interactions in a browser across the required scenarios. Deploy through the authorized project path when live changes are in scope, then reload and verify the actual served result. Label preview/source-only verification clearly; never attribute its grade to an unchanged live page.
4. **Evaluate:** Have the reviewer re-grade all units using the same rubric, refresh the coverage matrix and suggestions, and verify previously fixed problems did not recur. Shared CSS/navigation changes require checking every affected tab. Unavailable or unobserved areas remain unverified; unchanged code is not evidence of unchanged behavior.
5. **Checkpoint:** Update the scorecard, improvement/decision log, test evidence, and deployment status. In `commit-and-push` mode, make a scoped checkpoint commit covering the loop's remaining implementation and records, then push the intended branch. Inspect staged paths before committing; never include unrelated changes, overwrite work, force-push, or invent a remote. Do not create empty commits. If there is genuinely no new content, reference the existing checkpoint. Record the returned commit and push outcome in the next log update/final report rather than trying to embed a commit's own SHA inside itself. If push fails, preserve the local commit and report it; do not call the checkpoint pushed or rewrite history to force success.
6. **Decide:** Stop if every unit in every required scenario is verified at or above target and no unresolved task/accessibility blocker remains. Otherwise continue within the loop budget. Stop early when a concrete blocker prevents meaningful progress, or two consecutive loops yield neither a verified improvement nor an actionable next fix; document why. Never inflate grades, change weights, waive a failing scenario, or exceed the cap to declare success.

`mode=audit` ends after baseline and reporting, without refinement loops. If the cap is reached below target, deliver the completed work with an explicit unmet-target status and prioritized remaining suggestions. Distinguish UX target attainment from Git, deployment, or report-delivery failures.

## Report and deliver

Use the reference's report structure. Keep a durable local scorecard and improvement/decision log through the run, then write an executive summary with a detailed appendix. Include starting/final grades, every completed improvement, validation, judgment calls, remaining work, loop count, stopping reason, commits, push/deployment status, and limitations.

For Google Docs delivery, use the available Google Docs skill/connector and verify the returned document by reading it back. Keep sharing at the user's existing/default access unless broader sharing was requested. For email delivery, use the connected mail service to send the user a concise executive summary and the verified document link; an explicitly invoked workflow authorizes this summary email, not arbitrary messages or additional recipients. Resolve the recipient and sender account before sending. Verify the send result; a saved draft is not a sent email. Check for an existing document/message for this run before retrying an ambiguous creation/send so it is not duplicated.

If a connector or recipient is unavailable, complete local artifacts and all independent work, state the specific delivery blocker, and ask only for the missing information/access. Do not silently replace the requested Google Doc with a local file or claim a draft was delivered. Finish with links to available reports and a concise statement of results and unresolved obligations.

## Slate-pages adaptation

When the project is Slate-pages, read its applicable directory instructions and relevant references under `docs/agents/`, especially Liquid/HTML, frontend, portal activity, deployment, change reporting, and issue tracking for work records. For MGO Portfolio work also read `portals/mgo/INTEGRATED-PORTFOLIO-LAYOUT.md`. Use the owning portal's tracked `work/` conventions for reports.

Keep each Liquid command/expression on one physical line. Verify the live View/Part mapping before deployment, preserve required metadata and tracking, and follow the available Slate deployment skill when applicable. Git push does **not** deploy to Slate. Record local, pushed, deployed, and live-verified states separately. End any file-changing response with the required **Files changed** and **Slate-side setup required** lists and verified Slate links where applicable.

## Example invocation

```text
Use $usability-refinement on the portfolio page in my authenticated browser.
Review both named portfolio scenarios and every tab.
max_loops=4 target_grade=A- checkpoint=commit-and-push
delivery=google-doc-and-email
Deploy the scoped interface refinements to Slate and verify them live.
```

For review only: `Use $usability-refinement mode=audit target_grade=B+ delivery=local`.
