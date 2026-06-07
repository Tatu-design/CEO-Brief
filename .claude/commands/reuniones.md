---
name: reuniones
description: Busca y resume las reuniones de la última semana desde Google Drive. Extrae decisiones clave, acuerdos y cambios que afecten a los objetivos o al sprint activo.
---

# Comando: /reuniones

Consulta las transcripciones de reuniones de los últimos 7 días y genera un resumen ejecutivo.

## 1. Busca en Google Drive

- Busca archivos recientes con términos: "transcript", "transcripción", "Meet", "reunión", "recording"
- Filtra los creados en los últimos 7 días
- Lee el contenido de cada uno

## 2. También busca en Notion

- Busca páginas de tipo reunión o notas de reunión creadas esta semana
- Usa `notion-query-meeting-notes` si está disponible

## 3. Genera el resumen con este formato

```
## Reuniones de la semana — [fecha inicio] → [fecha fin]

### [Fecha] · [Tipo de reunión] · [Asistentes si constan]
**Decisiones:**
- [Decisión tomada]
**Cambios de prioridad:**
- [Si hay alguno]
**Próximos pasos acordados:**
- [Acciones con responsable si consta]

---
[Repetir para cada reunión]

### Impacto en sprint activo
[Lista de decisiones que afectan tareas del sprint actual]
```

## Reglas

- Si no hay transcripciones ni notas: *"No encontré reuniones registradas esta semana en Drive ni en Notion. ¿Quieres que te explique cómo activar las transcripciones de Google Meet?"*
- No inventes contenido. Solo resume lo que encuentres.
- Prioriza decisiones estratégicas sobre conversaciones operativas.
- Si una reunión tiene más de 30 minutos de transcripción, extrae solo los puntos de decisión.
