---
name: project-continuity
description: Preserve and restore project context across chat sessions. Use when the user asks to wrap up, hand off, checkpoint, or save state for the next session, or asks a new session to read in, catch up, resume, orient itself, or continue from the current project state. Accepts `handoff`, `checkpoint`, or `resume`, optionally followed by a project name. Not for one-off edits to AGENTS.md, CLAUDE.md, or docs that are unrelated to ending or starting a session.
---

# Project Continuity

Keep the durable project record aligned with reality so a fresh agent can resume without relying on chat history.

## Choose the mode

Infer the mode from the request or an argument supplied after the skill name:

- `handoff`: fully reconcile the project record at the end of a work session.
- `checkpoint`: a light mid-session save. Update only Current State, Next Steps, and Last Updated in the status file; skip full reconciliation and instruction-file edits.
- `resume`: load and verify the project record at the start of a session.
- If the request includes both resuming and work, run `resume` first and `handoff` after completing the work.
- If the mode is genuinely ambiguous, prefer `handoff` when the user mentions updating or saving state; otherwise prefer `resume`.

## Fix the scope

Respect an explicitly named project or subdirectory as the scope. Otherwise infer it from the working directory, conversation, changed files, and repository structure.

If more than one project is a plausible scope (for example, a repository containing several independent project folders and the conversation touched none or several of them), list the candidates and ask. Never guess in a multi-project repository. Never rewrite unrelated projects.

## Discover the sources of truth

Before editing or answering from project memory, inspect the current state, in this order:

1. Applicable instruction files: `AGENTS.md`, `CLAUDE.md`, nested variants, and relevant rule files. Follow any pointer they contain to a status file.
2. Repository state: `git status --short`, a diff summary, pertinent diffs, and recent commits (`git log --oneline -10 -- <scope>`) when they help explain the state.
3. Existing continuity files in scope. A good first search:
   `rg --files <scope> | rg -i '(status|handoff|context|memory|roadmap|milestone|plan|next|tasks|todo|discovery|research|decision|changelog)'`
4. Readmes, documentation indexes, and only the implementation or artifacts needed to verify specific claims.
5. Connected documents or trackers only when they are part of the requested scope and accessible through an available tool.

**Stopping rule:** once the primary status file and the records it links to are read and checked against git state, stop searching. Do not read every document.

Exclude `.git`, dependency/vendor directories, build outputs, caches, generated artifacts, archived worktrees, and copied repositories unless the user explicitly puts them in scope.

Treat the working tree and verified results as stronger evidence than stale prose. If the conversation has been compacted or summarized, trust the diff and git log over recollection of the chat. Preserve user changes and never discard or overwrite unrelated work.

## Where state belongs

| Kind of information | Home |
|---|---|
| Progress, current state, next steps, decisions, blockers | The project's status file (in the repository) |
| Durable operating rules, conventions, commands | `AGENTS.md` / `CLAUDE.md` / rule files |
| Facts about the user, their preferences, and feedback on how to work | The tool's own memory system (e.g. Claude Code auto-memory, Codex memories), if one exists |
| Long-form research, meeting notes, published pieces | Their existing files; link to them rather than copying |

Do not duplicate project progress into tool memory, and do not put user preferences into the project status file.

## Handoff mode

Build an evidence-based session delta from changed files, commands, results, current documentation, and the conversation. Then update the smallest set of authoritative files needed for continuity.

### Reconcile, do not broadcast

- Update existing sources of truth instead of copying the same status into every Markdown file.
- Do not interpret "all documentation" as permission to edit every `.md` file. Leave published pieces, historical notes, raw research, meeting records, third-party docs, and generated copies unchanged unless their content is directly affected.
- Keep instruction files focused on durable operating guidance. Put transient progress in the status, plan, milestone, task, discovery, or decision record.
- When equivalent Codex and Claude instruction files exist, keep shared facts consistent while preserving tool-specific wording and capabilities.
- If no continuity file exists and important state would otherwise be lost, create `PROJECT_STATUS.md` in the project root from [references/PROJECT_STATUS.template.md](references/PROJECT_STATUS.template.md), unless repository conventions indicate a better name. Never create a second tracker that competes with an existing one (e.g. an existing `TODO.md` or `plan.md`); extend that instead.
- **Make resume work without this skill:** ensure the nearest in-scope `AGENTS.md`/`CLAUDE.md` contains a one-line pointer to the status file, e.g. `Current status and next steps: see PROJECT_STATUS.md.` Add it only if absent.
- Use `YYYY-MM-DD` dates.

### What to capture

Follow the template's sections. A fresh session needs:

- objective and current scope;
- current state, including what remains uncommitted;
- completed work and material artifacts;
- decisions and the rationale that will matter later;
- discoveries, constraints, assumptions, and rejected approaches worth retaining;
- validation performed and its result;
- unresolved questions, blockers, risks, and external dependencies;
- exact next steps in useful order, with relevant file paths or commands;
- `Last updated: YYYY-MM-DD by <tool>`.

Do not claim work is complete without evidence. Label uncertainty explicitly. Remove or correct stale statements rather than appending a contradictory update.

### Keep it lean

Keep the status file under roughly 150 lines. When it grows past that, move completed items and settled decisions older than the current milestone into a `## History` section at the bottom, or into an existing `CHANGELOG.md`, leaving one-line summaries.

### Boundaries

- Do not change implementation merely to make documentation true.
- Do not commit, push, publish, send messages, close issues, or mutate external trackers unless the user separately requested that action.
- Local documents clearly included in the handoff request may be updated. Treat externally hosted documents and trackers as separate writes: update them only when the user explicitly included them or the active workflow already established that scope.
- Never copy secrets, credentials, private tokens, or sensitive raw data into handoff documents.
- Another session or worktree may be working in parallel. Re-read the status file immediately before writing it, and merge rather than overwrite if it changed since you first read it.

### Verify and report

After editing:

1. Re-read the changed sections and inspect the documentation diff.
2. Check that dates, links, milestone states, and commands are internally consistent, and that every file path named in Next Steps exists (or is explicitly marked "to be created").
3. Run lightweight relevant validation when available. Do not rerun expensive test suites solely for a documentation handoff unless needed to substantiate a claim.
4. Report the files updated, the durable state captured, validation performed, and anything intentionally left unresolved. See [references/examples.md](references/examples.md) for the shape.
5. End with the exact resume invocation for the same tool and project scope.

## Resume mode

Orient before proposing or changing anything, reading only what is needed:

1. Read the applicable instructions and the project's primary status file.
2. Read the linked milestone, task, discovery, and decision records relevant to the stated goal.
3. Inspect `git status --short`, relevant diffs, and recent commits so the documented state is checked against the actual workspace.
4. Open only the implementation, artifacts, or validation output needed to confirm the current state and the next step. Do not survey the codebase.
5. Resolve minor discrepancies from evidence. If a discrepancy could materially change the next action, surface it before proceeding rather than guessing.

Then give a compact orientation of about 10–15 lines (see [references/examples.md](references/examples.md)):

- project, and when/by what the record was last updated;
- the current objective and state;
- the last meaningful completed work;
- outstanding work or blockers;
- the next recommended action;
- any mismatch between documentation and the workspace.

If the invocation includes a task, continue with that task after orienting. If invoked alone, stop after the orientation and ask what the user wants to tackle next. Resume mode is read-only unless the user also asks to continue, repair stale memory, or make changes.

## Invocation examples

Codex:

```text
$project-continuity handoff
$project-continuity checkpoint
$project-continuity resume
$project-continuity resume the water-bill-site project, then continue the next documented step
```

Claude Code:

```text
/project-continuity handoff
/project-continuity checkpoint
/project-continuity resume
/project-continuity resume the water-bill-site project, then continue the next documented step
```
