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
