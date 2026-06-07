$input_data = $env:CLAUDE_TOOL_INPUT
if (-not $input_data) { exit 0 }

$blocked = @(
    "DROP DATABASE",
    "DROP TABLE",
    "TRUNCATE TABLE",
    "rm -rf /",
    "rm -rf ~",
    "format c:",
    "git push --force",
    "git reset --hard HEAD~",
    "git clean -fd"
)

foreach ($cmd in $blocked) {
    if ($input_data -match [regex]::Escape($cmd)) {
        Write-Host "BLOQUEADO: '$cmd' es una operacion destructiva irreversible."
        Write-Host "Si realmente necesitas esto, pidelo explicitamente y explica por que."
        exit 1
    }
}

$sensitive = @("\.env$", "\.env\.", "secrets/", "credentials", "private_key", "\.pem$", "\.key$")

foreach ($pattern in $sensitive) {
    if ($input_data -match $pattern) {
        Write-Host "BLOQUEADO: Intento de acceder a archivo sensible."
        Write-Host "Los archivos .env y credenciales nunca se leen ni editan por Claude."
        exit 1
    }
}

exit 0
