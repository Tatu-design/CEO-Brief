---
name: nuevo-sprint
description: Cierre del sprint que termina y apertura del siguiente. Revisa que quedo pendiente, que se mueve al proximo sprint y cual es el foco de la semana.
---

# Comando: /nuevo-sprint

Se ejecuta los lunes al inicio de cada semana para hacer el cierre del sprint anterior y la apertura del nuevo.

## Proceso

### Paso 1 — Cierre del sprint anterior
Lee en Notion el ultimo sprint (Estado = "Ultimo" o el mas reciente con Estado = "Anteriores"):
- Cuantas tareas quedaron sin completar (no DONE/CANCELLED)
- Cuales eran de alta prioridad y no se cerraron
- Porcentaje final de completado

### Paso 2 — Estado del sprint nuevo
Lee el sprint con Estado = "Actual":
- Fechas del sprint
- Tareas ya asignadas
- Distribucion por responsable

### Paso 3 — Genera el resumen de apertura

```
## Apertura Sprint [N] — [fecha inicio] al [fecha fin]

### Cierre del Sprint [N-1]
Completado: X% (N/N tareas)
Tareas pendientes que se arrastran: [lista con prioridad]

### Sprint [N] — Lo que hay planificado
Total tareas: [N]
Por responsable:
• [Persona]: N tareas
• [Persona]: N tareas

### Foco estrategico esta semana
[Que objetivos estrategicos avanza este sprint segun los OKRs]

### Decisiones necesarias para empezar bien
[Si hay tareas bloqueadas o sin responsable asignado]
```

### Paso 4 — Pregunta de alineacion
Termina preguntando: "Que quieres que el equipo priorice esta semana si hay conflicto entre tareas?"
