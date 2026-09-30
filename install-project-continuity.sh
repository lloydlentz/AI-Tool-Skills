#!/usr/bin/env bash
# Install this checkout's project-continuity skill without discarding local copies.
set -euo pipefail

skill_repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
skill_source="$skill_repo_root/project-continuity"
skill_backup_root="$HOME/.agents/skill-backups/project-continuity-$(date +%Y%m%dT%H%M%S)-$$"

if [[ ! -f "$skill_source/SKILL.md" ]]; then
  echo "Missing project-continuity/SKILL.md in this checkout." >&2
  exit 1
fi

install_link() {
  local destination="$1"
  local label="$2"
  if [[ -L "$destination" && "$destination" -ef "$skill_source" ]]; then
    echo "$label: already linked to this checkout."
    return
  fi
  mkdir -p "$(dirname -- "$destination")"
  if [[ -e "$destination" || -L "$destination" ]]; then
    mkdir -p "$skill_backup_root"
    mv -- "$destination" "$skill_backup_root/$label"
    echo "$label: previous installation saved at $skill_backup_root/$label"
  fi
  ln -s -- "$skill_source" "$destination"
  echo "$label: linked $destination to $skill_source"
}

install_link "$HOME/.agents/skills/project-continuity" codex
install_link "$HOME/.claude/skills/project-continuity" claude
