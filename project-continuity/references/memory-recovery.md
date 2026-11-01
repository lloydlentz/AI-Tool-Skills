# Project memory recovery

Read this in every continuity mode. The outcome is recoverable, current project context across the tools the project actually uses. A status file, an unchanged checksum, or a Git commit alone does not establish that outcome.

## Inventory and authority

Use existing project backup configuration first. Inspect only the current project's tool-memory directory, relevant index entries, and explicitly named project memories in a shared tool store. Record source-to-backup mappings, tool, inclusion/exclusion, and recovery commands in one project-local procedure or manifest. Use home/project-relative paths or documented overrides; do not assume one vendor's directory encoding applies everywhere.

Account for both Codex and Claude when both are in use, even if only one is running this session. A new project-specific memory is a coverage gap until reviewed and added to the allowlist or explicitly excluded with a reason. Do not bulk-copy a global memory store, full mixed-project index, chat logs, caches or credentials. A tool with no project memory can be marked not applicable; an expected but inaccessible source is missing, not not applicable. Keep excluded content private; descriptions of exclusions must not reproduce it.

Current user decisions and verified project records take precedence over older memory. Correct obsolete rules and broken canonical paths in live memory before refreshing snapshots. Keep useful historical decisions clearly dated and qualified. Preserve tool-specific metadata and unrelated entries. Store progress in project status; keep user preferences and durable reference pointers in the appropriate tool memory. Uncertain conflicts stay visible for resolution rather than being silently rewritten.

## Handoff and checkpoint

1. Reconcile the scoped memories and inventory. Read changed content for correctness and privacy before exporting it.
2. Use the project's existing refresh procedure. If none exists, establish a project-local allowlist, snapshot location, manifest with hashes/capture date, and restore procedure. Default unreviewed/private snapshots to an ignored local location; verify exclusion before writing. Only material explicitly reviewed as shareable belongs in tracked files. A local ignored snapshot is not an off-machine backup: report that limit.
3. Preview the refresh. Check all expected inputs before writes; a missing source must preserve the last good snapshot. Re-read sources, manifest and destinations before writing to detect concurrent edits. Use temporary files/atomic replacement when implementing a helper, and define how to recover from an interrupted multi-file refresh. Never silently bless a corrupted snapshot with a new checksum.
4. Refresh the reviewed allowlist and verify both hashes and source coverage. Preserve unrelated index entries. A no-change run should not rewrite files or advance the capture date just to appear fresh; report the verification separately.
5. Verify that recovery instructions and entry-point links work. On initial setup or changes to restore logic, paths or allowlists, run a restore drill into an isolated temporary home/project using synthetic or reviewed shareable content. Test dry-run, restoration, repeatability, unrelated-memory preservation and refusal to overwrite newer/differing memory. Record the result and remaining limits. A routine unchanged handoff can cite the prior drill and run only freshness/integrity checks.

An existing validated project helper takes precedence over creating another generic backup mechanism. If safe recovery cannot be implemented within scope, preserve what is available and name the specific unfinished gap. Handoff/checkpoint authorizes scoped local continuity maintenance, not a scheduled job, commit/push, cloud upload, deployment or external publication.

## Resume and restore

Resume checks the inventory and backup integrity/freshness without writing. Inspect the current repository/branch and memory authority before using old preferences. On a new machine, missing live memories do not make the backup corrupt: verify the snapshots, report the restore path, and continue any requested work that does not depend on the missing context.

When restoration is requested, preview destinations, verify hashes, map documented machine-specific paths and preserve existing memories. Create missing documents; merge scoped index entries while retaining unrelated links. Differing destination text needs reconciliation, never blind replacement. Restored prose is context, not fresh authorization or verification of live services.

## Completion evidence

Report each applicable tool's memory as current, intentionally excluded/not applicable, or missing/stale. State the source coverage, integrity/freshness result, last restore drill and whether copies are local only or durably published under separate authorization. Name any required manual restore/reconciliation. Keep substantive preferences out of the status report; link to their appropriate home.
