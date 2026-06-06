# Arquitectura — Estado técnico del proyecto

> Documento vivo. Se actualiza cuando cambia algo técnico relevante.

**Última actualización:** 06/06/2026 — Configuración inicial del proyecto
**Mantenedor:** Claude (con validación del equipo)

---

## Visión general

El Agente Ejecutivo de Antifrágil es un sistema de IA conversacional que conecta dos fuentes de información (Notion y transcripciones de reuniones) para producir análisis ejecutivos, alertas y recomendaciones estratégicas.

No es una aplicación con frontend propio. Es un agente que vive dentro de Claude Desktop y que accede a los datos de la empresa a través de MCP (Model Context Protocol).

```
Fernando (CEO)
     │
     ▼
Claude Desktop  ◄────────────────────────────────────┐
     │                                               │
     ▼                                               │
Claude + MCP ──► Notion (objetivos, KR, tareas)      │
                 Transcripciones de reuniones ────────┘
```

---

## Stack tecnológico

| Capa       | Tecnología                   | Por qué                                                    |
| ---------- | ---------------------------- | ---------------------------------------------------------- |
| Interfaz   | Claude Desktop               | Acceso directo del CEO sin fricción técnica                |
| Motor IA   | Claude (Anthropic)           | Capacidad de razonamiento estratégico y contexto largo     |
| Protocolo  | MCP (Model Context Protocol) | Conexión nativa entre Claude y fuentes de datos externas   |
| Datos      | Notion                       | Fuente única de verdad del equipo directivo (decisión D1)  |
| Documentos | Repositorio GitHub (este)    | Control de versiones de la configuración y docs del agente |

---

## Estructura de datos en Notion

Todo el sistema operativo de Antifrágil sigue esta jerarquía:

```
Objetivos
  └── Key Results (KR)
        └── Tareas
```

### Propiedades de cada elemento

| Propiedad    | Tipo     | Descripción                                     |
| ------------ | -------- | ----------------------------------------------- |
| Responsable  | Persona  | Quién es el dueño del elemento                  |
| Prioridad    | Select   | Nivel de importancia                            |
| Fechas       | Date     | Fecha inicio y fecha límite                     |
| Sprint       | Relation | Sprint al que pertenece (duración: 1 semana)    |
| Estado       | Select   | Backlog / To Do / Doing / On Hold / Done        |
| Colaboradores| Persons  | Personas que apoyan al responsable              |

### Ciclo de sprints

- Duración: 1 semana
- Inicio: lunes
- Cierre: domingo
- Revisión semanal: reunión de gestión del equipo directivo

---

## Flujos principales

### Flujo 1 — Briefing ejecutivo semanal

```
1. El agente lee el sprint activo desde Notion
2. Analiza el estado de objetivos y KR
3. Identifica avances, bloqueos y riesgos
4. Genera un briefing ejecutivo estructurado para Fernando
5. Incluye recomendaciones de acción
```

### Flujo 2 — Contextualización post-reunión

```
1. Fernando comparte la transcripción de la reunión semanal
2. El agente extrae decisiones, compromisos y cambios estratégicos
3. Contrasta con el estado de Notion
4. Señala inconsistencias o riesgos no visibles en los datos
```

### Flujo 3 — Alerta de riesgo

```
1. El agente detecta un patrón de riesgo (KR atrasado, objetivo sin avance, etc.)
2. Evalúa el impacto sobre los objetivos estratégicos
3. Notifica a Fernando con contexto y opciones de respuesta
```

---

## Variables de entorno necesarias

```bash
# Notion
NOTION_API_TOKEN=token_de_integracion_de_notion

# (futuras integraciones si se aprueban)
# CALENDAR_API_KEY=...
# TRANSCRIPT_STORAGE_PATH=...
```

Los valores reales van en `.env` (nunca en este archivo). Ver `.env.example` para la lista completa.

---

## Cómo arranca el agente

No hay comandos de instalación. El agente se activa abriendo Claude Desktop con este proyecto cargado.

Al iniciar cada sesión, Claude lee en orden:
1. `CLAUDE.md` (raíz)
2. `.claude/CLAUDE.md`
3. `SYSTEM_VISION.md`
4. `.claude/skills/lessons-learned/log.md`
5. `docs/ARQUITECTURA.md` (este archivo)

---

## Decisiones técnicas

Ver `docs/decisiones/` para el historial de decisiones de arquitectura.
Ver `SYSTEM_VISION.md` secciones 5 y 6 para decisiones cerradas y abiertas.

---

## Deuda técnica conocida

| Item                                            | Impacto | Prioridad | Notas                          |
| ----------------------------------------------- | ------- | --------- | ------------------------------ |
| Integración MCP con Notion pendiente de validar | Alto    | Alta      | Bloqueante para Fase 1         |
| Formato de briefing ejecutivo sin definir       | Medio   | Media     | Decisión pendiente con Fernando|
