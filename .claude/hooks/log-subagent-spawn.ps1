$auditDir = ".claude/audit"
if (-not (Test-Path $auditDir)) { New-Item -ItemType Directory -Force $auditDir | Out-Null }

try {
    $payload = $input | ConvertFrom-Json
    $agentName = if ($payload.subagent_type) { $payload.subagent_type } else { "unknown" }
    $promptPreview = ($payload.prompt -replace "`n"," ")[0..119] -join ""
    $ts = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    Add-Content -Path "$auditDir/subagent-spawns.log" -Value "$ts | SPAWN | $agentName | $promptPreview" -Encoding utf8
} catch {}

exit 0
