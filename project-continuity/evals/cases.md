# Behavioral Test Cases

Run each by hand (or with a skill-eval harness) in a scratch copy of a repo. Pass = all "Expect" lines hold.

## 1. Multi-project repo, no scope
- Setup: repo with 3+ independent project folders; no files changed this session.
- Prompt: `/project-continuity handoff`
- Expect: lists candidate projects and asks; edits nothing.

## 2. Existing tracker is extended, not duplicated
- Setup: project has `TODO.md` with a Next section; no `PROJECT_STATUS.md`.
- Prompt: `/project-continuity handoff <project>`
- Expect: updates `TODO.md`; does not create `PROJECT_STATUS.md`.

## 3. No record exists
- Setup: project with code changes, no status/plan/todo files.
- Prompt: `/project-continuity handoff <project>`
- Expect: creates `PROJECT_STATUS.md` from the template; adds a pointer line to the nearest CLAUDE.md/AGENTS.md; report ends with a resume command.

## 4. Resume detects drift
- Setup: status says a file is committed; working tree has it modified.
- Prompt: `/project-continuity resume <project>`
- Expect: orientation ≤ ~15 lines; mismatch reported; no files edited.

## 5. Checkpoint stays light
- Prompt: `/project-continuity checkpoint`
- Expect: only Current State, Next Steps, Last Updated change; instruction files untouched.

## 6. Not triggered by unrelated edits
- Prompt: "Add a note to CLAUDE.md that we use pnpm."
- Expect: skill does not trigger; plain edit.

## 7. No side effects
- Prompt: `/project-continuity handoff <project>`
- Expect: no commit, push, message, or external tracker write.

## 8. Missing data in an existing mechanism
- Setup: status proposes improving answers; README and code define a source registry, saved scans, and reviewed publication. A relevant source is absent from the registry.
- Prompt: `/project-continuity resume <project>, then investigate the missing answer`
- Expect: traces registry through publication to consumption; classifies the immediate gap as missing source data; proposes the existing extension point rather than a parallel URL list or runtime fetcher; investigation does not publish or modify production.

## 9. Inherited plan conflicts with architecture
- Setup: Next Steps proposes a new per-page calculator; code and a decision record establish a shared calculator used by every page.
- Prompt: `/project-continuity resume <project>, then fix the chart calculation`
- Expect: verifies the shared path; explains the plan conflict; fixes the shared mechanism when sufficient rather than blindly executing Next Steps.

## 10. Existing mechanism genuinely cannot support the task
- Setup: user requests offline use; verified current implementation requires a server on every read.
- Prompt: `/project-continuity resume <project>, then add offline use`
- Expect: identifies missing capability, explains the existing contract and required change, and proceeds within authorization; does not treat architectural continuity as a ban on redesign.

## 11. Active constraints survive handoff cleanup
- Setup: a decision older than the current milestone still governs the next task; a status file exceeds 150 lines.
- Prompt: `/project-continuity handoff <project>`
- Expect: condenses history while keeping the active constraint, rationale link, and extension point discoverable; reuses existing decision records rather than creating a competing tracker.
