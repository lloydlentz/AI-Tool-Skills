# AI Tool Skills

Reusable personal skills for Codex and Claude Code.

| Skill | Purpose |
| --- | --- |
| [project-continuity](project-continuity/SKILL.md) | Save a handoff, checkpoint progress, or resume from a project's durable record. |
| [meeting-summary](meeting-summary/SKILL.md) | Turn meeting transcripts into summaries and action items. |

## Install project-continuity

### Mac and Linux

On each Mac or Linux machine:

```bash
mkdir -p "$HOME/code"
git clone https://github.com/lloydlentz/AI-Tool-Skills.git "$HOME/code/AI-Tool-Skills"
bash "$HOME/code/AI-Tool-Skills/install-project-continuity.sh"
```

If the repository is already cloned, use that checkout and run its installer.
The installer links the skill into `~/.agents/skills/project-continuity` for
Codex and `~/.claude/skills/project-continuity` for Claude Code. Existing
installations are backed up under `~/.agents/skill-backups/` before replacement;
other skills are left alone. Start a new session after installing.

The links point to this checkout. Keep it in place; edit the files here to
update the installed skill. To get published updates on another machine:

```bash
git -C "$HOME/code/AI-Tool-Skills" pull --ff-only
```

### Windows PC (PowerShell)

With Git installed, open PowerShell and run:

```powershell
New-Item -ItemType Directory -Force "$HOME\code" | Out-Null
git clone https://github.com/lloydlentz/AI-Tool-Skills.git "$HOME\code\AI-Tool-Skills"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$HOME\code\AI-Tool-Skills\install-project-continuity.ps1"
```

If you already cloned the repository, skip the clone command. Start a new
Codex or Claude Code session after installation. The installer copies the
complete skill into:

- Codex: `%USERPROFILE%\.agents\skills\project-continuity`
- Claude Code: `%USERPROFILE%\.claude\skills\project-continuity`

It backs up previous installations under
`%USERPROFILE%\.agents\skill-backups\`. Copies avoid requiring administrator
access for symbolic links. The execution-policy option applies only to that
PowerShell invocation.

Because Windows uses copies, pull updates and rerun the installer:

```powershell
git -C "$HOME\code\AI-Tool-Skills" pull --ff-only
if ($LASTEXITCODE -eq 0) {
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$HOME\code\AI-Tool-Skills\install-project-continuity.ps1"
}
```

If running the agent inside WSL, use the Linux instructions inside WSL instead.

The install locations follow the official
[Codex skills documentation](https://developers.openai.com/codex/skills) and
[Claude Code skills documentation](https://code.claude.com/docs/en/skills).
The PowerShell installer has not yet been execution-tested on a Windows PC.

### Sharing

This is also a public repository that others can clone and install. If using
an agent with a different skill location, copy the whole `project-continuity/`
directory there, including `references/` and `agents/`.

## Use project-continuity

Codex:

```text
$project-continuity handoff transcript_decoding
$project-continuity checkpoint transcript_decoding
$project-continuity resume transcript_decoding
```

Claude Code uses the same arguments with `/project-continuity`.

The skill and project records are separate. This repository contains the
reusable instructions; each project's status and milestones stay in its own
repository. Share those project documents separately so another machine or
collaborator can resume. Protected records, generated outputs, and credentials
are not included here.
