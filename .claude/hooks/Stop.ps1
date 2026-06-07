Write-Host ""
Write-Host "==============================================================="
Write-Host "  Fin de sesion"
Write-Host "==============================================================="
Write-Host ""
Write-Host "  Antes de cerrar, comprueba:"
Write-Host "  - Hubo correcciones en esta sesion? -> Registra la leccion (/nueva-leccion)"
Write-Host ""
Write-Host "  - Cambios sin commitear:"
$gitStatus = git status --short 2>$null | Select-Object -First 5
if ($gitStatus) {
    $gitStatus | ForEach-Object { Write-Host "    $_" }
} else {
    Write-Host "    (todo commiteado)"
}
Write-Host ""
Write-Host "  - Decisiones nuevas que anadir a SYSTEM_VISION.md?"
Write-Host ""
Write-Host "==============================================================="
