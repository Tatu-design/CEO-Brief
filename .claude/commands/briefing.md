---
name: briefing
description: Genera el briefing ejecutivo completo — sprint activo, objetivos, alertas y recomendaciones estratégicas. Usa este comando para tener el estado de Antifrágil en cualquier momento.
---

# Comando: /briefing

Cuando Fernando invoca este comando:

## 1. Lee Notion en tiempo real

**Sprint activo:**
- Base de datos: Sprints Gestión (`collection://c0aab352-6dd1-421e-b29a-61bad82436fa`)
- Filtra por Estado del sprint = "Actual"
- Obtén: nombre, fechas, total de tareas, % completadas

**Tareas del sprint:**
- Base de datos: Tareas Gestión (`collection://829562c1-b65a-4558-aa01-16c1e74c638d`)
- Usa la vista "Por estado" del sprint activo
- Agrupa por: DONE / DOING / TO DO / ON HOLD / BACKLOG
- Identifica: tareas vencidas (fecha límite ≤ hoy, no DONE), tareas ⭕Alta en ON HOLD

**Objetivos:**
- Base de datos: Objetivos (`collection://1d70a899-f857-81ce-99d0-000bc35956e5`)
- Filtra por: Cuarto = trimestre actual, Estado ≠ Listo/Cancelado
- Identifica: objetivos "Sin empezar" con cuarto en curso (riesgo alto)

## 2. Genera el briefing con este formato

```
## Briefing Ejecutivo — [fecha]
**Sprint [N]** · [fecha inicio] → [fecha fin]

---

### Estado del sprint
| Estado | Tareas | % |
|--------|--------|---|
| ✅ DONE | N | X% |
| 🔵 DOING | N | X% |
| ⬜ TO DO | N | X% |
| 🟡 ON HOLD | N | X% |
Total: N tareas

---

### Alertas activas
[Lista solo lo que necesita atención inmediata]
- 🔴 [Tarea vencida + quién es responsable]
- 🟡 [ON HOLD ⭕Alta + por qué está bloqueada si se sabe]
- ⚠️ [Objetivo en riesgo]

---

### En curso
[Tareas en DOING — quién las lleva]

---

### Estado de objetivos [trimestre]
[Tabla: Objetivo / Estado / Riesgo]

---

### Recomendaciones
[2-3 acciones concretas para Fernando hoy/esta semana]

→ Decisión tuya: [Si hay algo que requiere su decisión]
```

## 3. Después del briefing

Pregunta: *"¿Quieres profundizar en algún objetivo, persona o bloqueo concreto?"*
