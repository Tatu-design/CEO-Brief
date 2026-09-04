# Agente Ejecutivo de Antifrágil — Documento Técnico

**Versión:** 1.0 · **Fecha:** Junio 2026  
**Preparado por:** Fernando Campos (CEO)  
**Destinatario:** CTO / Dirección Técnica

---

## ¿Qué es este sistema?

El Agente Ejecutivo de Antifrágil es un **Chief of Staff digital** para el CEO. Cada mañana a las 6:00h genera un briefing ejecutivo automático con el estado real de la empresa — tareas, objetivos, bloqueos y decisiones de reuniones — sin que el CEO tenga que consultar ninguna herramienta manualmente.

No es un chatbot genérico. Es un agente configurado específicamente para Antifrágil, con acceso a los datos reales de la empresa y reglas de comportamiento definidas por el CEO.

---

## Arquitectura general

```
┌─────────────────────────────────────────────────────────────┐
│                    FUENTES DE DATOS                         │
│                                                             │
│  Notion (tareas, sprints, objetivos)                        │
│  Google Drive (transcripciones de reuniones)                │
│  Gmail (borradores del briefing diario)                     │
│  Google Calendar (disponibilidad y reuniones)               │
└──────────────────────┬──────────────────────────────────────┘
                       │ MCP (Model Context Protocol)
                       │ Conexión directa, sin APIs intermedias
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                  CLAUDE CODE DESKTOP                        │
│                                                             │
│  Motor de IA: Claude Sonnet 4.6 (Anthropic)                 │
│  Interfaz: Aplicación de escritorio (Windows/Mac)           │
│  Configuración: .claude/ dentro del repositorio             │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                     SALIDAS                                 │
│                                                             │
│  Briefing en pantalla (Claude Code Desktop)                 │
│  Borrador en Gmail (fcmarcos12@gmail.com)                   │
│  Página en Notion (📋 Briefings Ejecutivos)                 │
└─────────────────────────────────────────────────────────────┘
```

---

## Componentes técnicos

### 1. Claude Code Desktop
Aplicación de escritorio de Anthropic (disponible para Windows y Mac). Actúa como interfaz conversacional del CEO con el agente. El CEO escribe comandos o preguntas en lenguaje natural; el agente responde con datos reales de Notion y Drive.

**Por qué Claude Code y no una app custom:** Claude Code ya tiene integración nativa con MCP, gestión de permisos, hooks de automatización y soporte para comandos personalizados. Construir una app equivalente requeriría meses de desarrollo y mantenimiento continuo.

### 2. MCP — Model Context Protocol
Protocolo estándar de Anthropic que permite al agente conectarse directamente con herramientas externas (Notion, Gmail, Drive, Calendar) sin necesidad de APIs intermedias ni código de integración. Las conexiones están configuradas en Claude Code Desktop.

**Conexiones activas:**
| Herramienta | Uso |
|-------------|-----|
| Notion | Leer sprint, tareas y objetivos en tiempo real |
| Google Drive | Leer transcripciones de reuniones |
| Gmail | Crear borradores con el briefing diario |
| Google Calendar | Consultar agenda y reuniones |

### 3. Repositorio del proyecto
Directorio local: `C:\Users\usuario\Desktop\CEO Breaf`  
Repositorio GitHub: `https://github.com/Tatu-design/CEO-Brief`

Contiene toda la configuración del agente:

```
CEO Breaf/
├── CLAUDE.md                     ← Punto de entrada (puntero)
├── SYSTEM_VISION.md              ← Contexto estratégico de Antifrágil
├── .claude/
│   ├── CLAUDE.md                 ← Constitución del agente (identidad, reglas, protocolo)
│   ├── settings.json             ← Permisos y hooks del sistema
│   ├── commands/                 ← Comandos slash disponibles
│   │   ├── briefing.md           ← /briefing — Briefing ejecutivo completo
│   │   ├── sprint.md             ← /sprint — Estado rápido del sprint
│   │   ├── alertas.md            ← /alertas — Solo urgencias
│   │   ├── reuniones.md          ← /reuniones — Resumen de reuniones de la semana
│   │   ├── publicar-notion.md    ← /publicar-notion — Publica en Notion
│   │   └── nuevo-sprint.md       ← /nuevo-sprint — Cierre y apertura de sprint
│   ├── hooks/
│   │   └── SessionStart.sh       ← Se ejecuta al abrir una sesión nueva
│   └── skills/
│       └── lessons-learned/
│           └── log.md            ← Registro de lecciones aprendidas (memoria del agente)
└── docs/
    ├── ARQUITECTURA.md           ← Estado técnico y esquema de bases de datos Notion
    ├── ROADMAP.md                ← Fases del proyecto
    └── CHANGELOG.md              ← Historial de cambios
```

### 4. Automatización diaria (6:00h Madrid)
Un agente remoto programado ejecuta el briefing automáticamente cada mañana a las 6:00h (4:00h UTC). El resultado llega al CEO como borrador en Gmail y como página en Notion.

**Tecnología:** RemoteTrigger de Claude Code (routines) con cron `0 4 * * *`.

---

## Bases de datos de Notion conectadas

El agente tiene acceso de lectura y escritura a cuatro bases de datos del workspace de Antifrágil:

| Base de datos | ID de colección | Uso |
|---------------|-----------------|-----|
| Sprints Gestión | `c0aab352-...` | Sprint activo, fechas, % completado |
| Tareas Gestión | `829562c1-...` | Tareas por estado, responsable, prioridad, fecha límite |
| Objetivos | `1d70a899-...` | OKRs por trimestre y estado |
| Proyectos (KRs) | `1d70a899-818d-...` | Key Results vinculados a objetivos |

**Estados de tareas reconocidos:** `DONE`, `DOING`, `TO DO`, `ON HOLD`, `BACKLOG`, `CANCELLED`  
**Prioridades:** `⭕Alta`, `Media`, `Baja`

---

## Flujo del briefing diario

```
06:00h Madrid
    │
    ▼
1. Busca en Google Drive (carpeta "📋 Transcripciones Reuniones")
   → Si hay transcripciones de los últimos 7 días, extrae decisiones relevantes
    │
    ▼
2. Lee Notion en tiempo real
   → Sprint activo (Estado = "Actual")
   → Tareas del sprint agrupadas por estado
   → Objetivos del trimestre actual (Q2 2026)
    │
    ▼
3. Genera el briefing ejecutivo
   → Tabla de estado del sprint (DONE/DOING/TO DO/ON HOLD)
   → Alertas: tareas vencidas, ON HOLD de alta prioridad, objetivos en riesgo
   → Tareas en curso con responsable
   → Decisiones de reuniones (solo si hay contenido relevante)
   → 2-3 recomendaciones concretas para el CEO
    │
    ▼
4. Publica en dos destinos
   → Borrador en Gmail (fcmarcos12@gmail.com)
   → Subpágina en Notion: "Briefings Ejecutivos" > "Briefing DD/MM/YYYY"
```

---

## Flujo de transcripciones de reuniones

### Reuniones por Google Meet
```
Reunión en Meet → Activar transcripción → Se guarda automáticamente en Drive
```

### Reuniones presenciales
```
Grabadora de voz → Transcripción (Otter.ai / Whisper) → Guardar en carpeta Drive
```

**Carpeta de destino:**  
`Grupo Empresarial Antifrágil SL → 5. Operativa → 📋 Transcripciones Reuniones`  
ID Drive: `1YY7NXOIEfv0t77GISymtvB7FMGfzKkXY`

**Convención de nombres:** `YYYY-MM-DD Nombre de la reunión.txt`  
Ejemplo: `2026-06-07 Reunión equipo directivo.txt`

---

## Comandos disponibles para el CEO

El CEO escribe estos comandos directamente en Claude Code Desktop:

| Comando | Descripción |
|---------|-------------|
| `/briefing` | Briefing ejecutivo completo: sprint, objetivos, alertas, reuniones y recomendaciones |
| `/sprint` | Snapshot rápido del sprint en <15 líneas: % completado, en curso, bloqueados |
| `/alertas` | Solo lo urgente: tareas vencidas, ON HOLD de alta prioridad, objetivos en riesgo |
| `/reuniones` | Resumen de reuniones de la última semana desde Drive y Notion |
| `/publicar-notion` | Publica el último briefing en Notion para que el equipo directivo lo vea |
| `/nuevo-sprint` | Cierre del sprint que termina y apertura del siguiente con foco de la semana |

---

## Seguridad y permisos

- El agente tiene permisos de **lectura y escritura limitada**: puede leer datos de Notion y Drive, crear borradores en Gmail y crear páginas en Notion. No puede borrar datos.
- Las credenciales de MCP están almacenadas en Claude Code Desktop (cifradas localmente), nunca en el repositorio.
- Reglas de denegación explícitas en `.claude/settings.json`: no puede commitear archivos `.env`, credenciales ni ejecutar comandos destructivos de git.
- El repositorio en GitHub es **privado**.

---

## Sistema de aprendizaje

El agente mantiene un log de lecciones aprendidas en `.claude/skills/lessons-learned/log.md`. Cada vez que el CEO corrige su comportamiento o forma de trabajar, el agente registra la lección antes de continuar. El objetivo es que el agente no cometa el mismo error dos veces a lo largo del tiempo.

---

## Fases del proyecto

| Fase | Estado | Descripción |
|------|--------|-------------|
| 1. Briefing diario | ✅ Activo | Sprint + objetivos + reuniones + Gmail + Notion |
| 2. Gestión de equipo | 🔜 Siguiente | Estado por director, carga de trabajo, bloqueos |
| 3. Alertas proactivas | 🔜 Planificado | El agente notifica sin que el CEO pregunte |
| 4. Integración financiera | 🔜 Planificado | Datos de facturación y tesorería en el briefing |
| 5. Análisis estratégico | 🔜 Planificado | Comparación de OKRs vs. ejecución real trimestral |

---

## Stack tecnológico

| Componente | Tecnología |
|------------|------------|
| Motor IA | Claude Sonnet 4.6 (Anthropic) |
| Interfaz CEO | Claude Code Desktop (Windows) |
| Protocolo de integración | MCP (Model Context Protocol) |
| Gestión de tareas | Notion |
| Documentos y transcripciones | Google Drive |
| Comunicación | Gmail |
| Agenda | Google Calendar |
| Control de versiones | Git + GitHub (repo privado) |
| Automatización diaria | Claude Code Routines (cron) |

---

## Contacto y mantenimiento

El sistema está diseñado para ser mantenido por el propio CEO con asistencia del agente. Los cambios de configuración (nuevos comandos, ajustes del briefing, nuevas fuentes de datos) se realizan modificando los archivos `.md` del repositorio y commiteando los cambios.

Para ampliaciones técnicas que requieran nuevas integraciones MCP o cambios de arquitectura, se recomienda coordinar con el CTO.
