---
name: sprint
description: Snapshot rápido del sprint activo — porcentaje completado, qué está en curso, qué está bloqueado y qué vence pronto.
---

# Comando: /sprint

Genera un snapshot rápido del sprint activo en menos de 15 líneas.

## Lee de Notion

- Sprint activo en Sprints Gestión (Estado = "Actual")
- Tareas del sprint: cuenta por estado
- Tareas vencidas o que vencen hoy (fecha límite menor o igual a hoy, no DONE)
- Tareas de prioridad Alta en ON HOLD

## Formato de salida

```
**Sprint [N]** · [fecha inicio] → [fecha fin] · Día [X] de 7

[████████░░] X% completado  (N de N tareas DONE)

✅ DONE [N]   🔵 DOING [N]   ⬜ TO DO [N]   🟡 ON HOLD [N]

En curso ahora:
• [Tarea — Responsable]
• [Tarea — Responsable]

Alertas:
🔴 Vencidas hoy: [nombre de tarea(s)]
🟡 Bloqueadas alta prioridad: [nombre de tarea(s)]
```

## Reglas de interpretación

- Si no hay alertas: *"Sin alertas. Sprint avanzando con normalidad."*
- Si quedan ≤ 2 días y completado < 50%: añade *"⚠️ Sprint cierra en [N] días con [X]% completado. ¿Revisamos qué pasa al siguiente sprint?"*
- Si ON HOLD > 30% del total: añade *"⚠️ Más de un tercio del sprint está bloqueado. Puede indicar dependencias externas sin resolver."*
