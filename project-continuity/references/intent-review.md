# Continuity intent review — 2026-11-01

Intent: a fresh session or machine should recover the right project state,
working preferences and design constraints without depending on the old chat.

| Gap in the previous skill | Change |
|---|---|
| Tool memory had a home but no required maintenance/recovery step | Mandatory scoped inventory, reconciliation and backup refresh |
| Checkpoint restricted edits to three status fields | Changed memories and backups included in checkpoints |
| Matching backups could preserve obsolete instructions | Separate semantic freshness from checksum freshness |
| Only existing Codex/Claude instruction files were synchronized | Add missing tool entry points to shared status/recovery instructions |
| New memory files and missing sources could go unnoticed | Coverage accounting, reviewed allowlists and explicit partial completion |
| No first-use backup or new-machine path | Project-local setup, privacy defaults, path mapping and safe restore |
| “Saved” could mean only on one disk | Distinguish local snapshots, committed/pushed backups and live deployments |
| No proof that recovery worked | Initial/changed restore drill; routine freshness checks thereafter |

The upstream architecture-verification requirements are preserved: verify the
existing mechanism and classify the gap before implementing a new design.

## Consider later

- **Off-machine backup for excluded private memories.** Choose an approved
  destination, encryption/key custody and retention before adding transport.
  Git can preserve reviewed shareable text; an ignored local snapshot alone
  cannot survive disk loss.
- **Scheduled drift checks.** Useful between continuity calls, but require a
  separate scheduling request. The skill runs when invoked; it is not a daemon.
- **Portable helper package and CI.** Generalize proven project helpers after
  testing differing memory layouts and Windows paths. CI can verify tracked
  integrity and synthetic restore fixtures, but cannot establish freshness
  against memories that only exist on a user's machine.
- **Agent execution evaluations.** The scenario list is an acceptance rubric;
  static review and project restore tests do not prove that both assistants
  will follow every branch. Run isolated Codex/Claude sessions against fixtures
  before claiming behavioral evaluation coverage.

These are optional follow-ups, not prerequisites for using the updated skill.
No background synchronization, cloud upload or copying of unrelated personal
memories is introduced.
