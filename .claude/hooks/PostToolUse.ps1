$tool = $env:CLAUDE_TOOL_NAME

if ($tool -eq "Write" -or $tool -eq "Edit") {
    $auditDir = ".claude/audit"
    if (-not (Test-Path $auditDir)) { New-Item -ItemType Directory -Force $auditDir | Out-Null }
    $ts = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    $entry = "$ts | $tool | $($env:CLAUDE_TOOL_INPUT -replace "`n"," ")"
    Add-Content -Path "$auditDir/edits.log" -Value $entry -Encoding utf8
}

exit 0
