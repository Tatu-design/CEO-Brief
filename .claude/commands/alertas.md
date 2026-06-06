---
name: alertas
description: Muestra solo lo urgente — tareas vencidas, bloqueos de alta prioridad y objetivos en riesgo. Sin contexto extra, directo al problema.
---

# Comando: /alertas

Muestra únicamente lo que necesita atención inmediata. Sin resumen de estado, sin contexto. Solo alertas accionables.

## Lee de Notion

1. **Tareas vencidas**: fecha límite < hoy, Estado != DONE/CANCELLED
2. **Bloqueadas críticas**: Estado = ON HOLD + Prioridad = Alta
3. **Objetivos en riesgo**:
   - Estado = "Sin empezar" con Cuarto = trimestre actual
   - Estado = "En progreso" arrastrándose desde cuartos anteriores
4. **Sprint en riesgo**: si quedan 2 dias o menos y DONE < 40%

## Formato de salida

Si hay alertas:

```
## Alertas — [fecha]

VENCIDAS ([N])
• [Tarea] — [Responsable] — vencio el [fecha]

BLOQUEADAS ALTA PRIORIDAD ([N])
• [Tarea] — ON HOLD — limite [fecha]

OBJETIVOS EN RIESGO ([N])
• [OBX: Nombre] — [motivo del riesgo]

Accion recomendada: [que deberia hacer Fernando ahora mismo]
```

Si no hay alertas:

```
Sin alertas criticas a [fecha].
El sprint avanza con normalidad. Proximo vencimiento importante: [tarea — fecha].
```

## Regla importante

No añadas contexto que no sea urgente. Este comando es para cuando Fernando quiere saber en 10 segundos si hay algo que le requiere atencion. Si no hay nada urgente, dilo claro y rapido.
