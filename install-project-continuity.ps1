# Copy the skill into native Windows agent folders, preserving prior installs.
[CmdletBinding()]
param(
    [string]$ProfileRoot = [Environment]::GetFolderPath('UserProfile')
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($ProfileRoot)) {
    throw 'The user profile directory could not be resolved.'
}
$skillSource = Join-Path $PSScriptRoot 'project-continuity'
$backupRoot = Join-Path $ProfileRoot ('.agents\skill-backups\project-continuity-' + [Guid]::NewGuid().ToString('N'))

if (-not (Test-Path -LiteralPath (Join-Path $skillSource 'SKILL.md') -PathType Leaf)) {
    throw 'Missing project-continuity/SKILL.md in this checkout.'
}
function Install-SkillCopy {
    param([string]$Destination, [string]$Label)

    $parentDirectory = Split-Path -Parent $Destination
    $stagingDirectory = Join-Path $parentDirectory ('.project-continuity-install-' + [Guid]::NewGuid().ToString('N'))
    $backupDirectory = Join-Path $backupRoot $Label
    $previousSaved = $false

    New-Item -ItemType Directory -Force -Path $parentDirectory | Out-Null
    try {
        Copy-Item -LiteralPath $skillSource -Destination $stagingDirectory -Recurse
        if (Test-Path -LiteralPath $Destination) {
            New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
            Move-Item -LiteralPath $Destination -Destination $backupDirectory
            $previousSaved = $true
            Write-Host "${Label}: previous installation saved at $backupDirectory"
        }
        Move-Item -LiteralPath $stagingDirectory -Destination $Destination
        Write-Host "${Label}: installed at $Destination"
    }
    catch {
        if ($previousSaved -and -not (Test-Path -LiteralPath $Destination)) {
            Move-Item -LiteralPath $backupDirectory -Destination $Destination
        }
        throw
    }
    finally {
        if (Test-Path -LiteralPath $stagingDirectory) {
            Remove-Item -LiteralPath $stagingDirectory -Recurse -Force
        }
    }
}

Install-SkillCopy -Destination (Join-Path $ProfileRoot '.agents\skills\project-continuity') -Label 'codex'
Install-SkillCopy -Destination (Join-Path $ProfileRoot '.claude\skills\project-continuity') -Label 'claude'
