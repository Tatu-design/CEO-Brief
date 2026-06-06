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

La jerarquía operativa real de Antifrágil es:

```
Objetivos
  └── Proyectos (= Key Results en la nomenclatura interna: OBX-KR2, OB7-KR6...)
        └── Tareas Gestión  ←──── Sprints Gestión (dimensión transversal)
```

### Base de datos: Objetivos
`collection://1d70a899-f857-81ce-99d0-000bc35956e5`

| Propiedad   | Tipo     | Valores posibles                                    |
| ----------- | -------- | --------------------------------------------------- |
| Nombre      | Título   | —                                                   |
| Estado      | Status   | Sin empezar / En progreso / Listo / Cancelado       |
| Prioridad   | Select   | Baja / Media / Alta                                 |
| Cuarto      | Select   | Q1 2026 / Q2 2026 / Q3 2026 / ...                  |
| Líder       | Persona  | Responsable del objetivo                            |
| Colaborador | Personas | Apoyo al líder                                      |
| Proyectos   | Relación | KRs asociados (base de datos Proyectos)             |
| Blocked by  | Relación | Objetivos que lo bloquean                           |

### Base de datos: Proyectos (Key Results)
`collection://1d70a899-f857-818d-871f-000b9832d4ee`

Cada KR se nombra con la convención `OBX-KRN: descripción` (ej: `OB7-KR6: Sistema de comunicación interna`).
Relaciona Objetivos con Tareas Gestión.

### Base de datos: Tareas Gestión
`collection://829562c1-b65a-4558-aa01-16c1e74c638d`

| Propiedad      | Tipo     | Valores posibles                             |
| -------------- | -------- | -------------------------------------------- |
| Título         | Título   | —                                            |
| Estado         | Status   | BACKLOG / TO DO / DOING / ON HOLD / DONE / CANCELLED |
| Responsable    | Persona  | Dueño de la tarea                            |
| Prioridad      | Select   | ⭕Alta / Media / Baja                        |
| Fecha límite   | Fecha    | —                                            |
| Sprint         | Relación | Sprint al que pertenece (límite: 1)          |
| Proyecto Nuevo | Relación | KR al que pertenece                          |
| Subtareas      | Relación | Tareas hijas (autorreferencial)              |
| Tarea principal| Relación | Tarea padre (autorreferencial)               |
| Bloqueado por  | Relación | Tareas que la bloquean                       |
| ID de la tarea | Auto-ID  | Identificador numérico único                 |

### Base de datos: Sprints Gestión
`collection://c0aab352-6dd1-421e-b29a-61bad82436fa`

| Propiedad          | Tipo    | Valores / descripción                                  |
| ------------------ | ------- | ------------------------------------------------------ |
| Nombre             | Título  | —                                                      |
| Fechas             | Fecha   | Rango fecha inicio – fin del sprint                    |
| ID de sprint       | Auto-ID | —                                                      |
| Estado del sprint  | Status  | Actual / Siguiente / Futuro / Último / Anteriores      |
| Tareas             | Relación| Tareas asignadas a este sprint                         |
| Tareas completadas | Rollup  | % de tareas en estado DONE sobre el total              |
| Total de tareas    | Rollup  | Número total de tareas del sprint                      |

### Ciclo de sprints

- Duración: 1 semana
- Estado "Actual": sprint en curso (solo uno a la vez)
- Revisión semanal: reunión de gestión del equipo directivo con transcripción

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
