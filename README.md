# Claude Project Template

> Una estructura de proyecto lista para usar con Claude Code.
> Diseñada para que **personas con contexto de negocio** puedan construir proyectos
> reales sin necesidad de conocimientos técnicos previos.
> **Claude actúa como el técnico. Tú aportas el negocio.**

---

## ¿Por dónde empiezo?

```
1. Rellena SYSTEM_VISION.md  →  tu visión del proyecto
2. Abre la carpeta en Claude Code
3. Dile: "Lee el SYSTEM_VISION.md y cuéntame qué entiendes"
4. A partir de ahí, Claude te guía
```

¿Primera vez? Lee primero [docs/GETTING-STARTED.md](docs/GETTING-STARTED.md) — guía paso a paso en lenguaje normal.
¿Una palabra que no entiendes? Búscala en [docs/DICCIONARIO.md](docs/DICCIONARIO.md).

---

## El archivo más importante

### [SYSTEM_VISION.md](SYSTEM_VISION.md) — La visión del proyecto ⭐
**Lo rellenas tú.** Es el documento central donde describes qué es el proyecto,
para quién es, qué decisiones ya están tomadas y cuáles están pendientes.
Claude lo lee al inicio de cada sesión para entender el contexto sin que tengas
que repetirlo cada vez.

---

## La capa de Claude (`.claude/`)

> Todo lo que hay aquí configura cómo se comporta Claude. No necesitas tocarlo
> para empezar — funciona solo. Pero si quieres entenderlo, cada carpeta tiene su README.

### [.claude/CLAUDE.md](.claude/CLAUDE.md) — Constitución del agente
Las reglas del juego entre tú y Claude: quién decide qué, cómo se comunica,
qué está prohibido, cómo aprende de los errores. El documento más importante
de esta capa.

### [.claude/hooks/](.claude/hooks/README.md) — Automatizaciones
Pequeños programas que se ejecutan solos en momentos clave: al abrir sesión,
antes de un comando peligroso, al cerrar. Incluye protecciones de seguridad
para que Claude no pueda hacer operaciones destructivas sin tu permiso.

### [.claude/agents/](.claude/agents/README.md) — Agentes especializados
Versiones de Claude enfocadas en áreas concretas: arquitectura, backend, frontend,
calidad, seguridad, análisis de negocio. Claude principal los convoca cuando
necesita expertise específico para una tarea.

### [.claude/skills/](.claude/skills/) — Conocimiento del proyecto
Paquetes de conocimiento que Claude carga según el contexto:
- [lessons-learned/](.claude/skills/lessons-learned/log.md) — memoria de errores y correcciones pasadas
- [git-protocol/](.claude/skills/git-protocol/SKILL.md) — cómo gestionar los cambios de código
- [project-context/](.claude/skills/project-context/SKILL.md) — contexto de negocio del proyecto (tú lo rellenas)

### [.claude/commands/](.claude/commands/) — Atajos de trabajo
Comandos que puedes invocar escribiendo `/nombre` en Claude Code:
- `/nueva-leccion` — registra algo que Claude debe recordar
- `/revisar-cambios` — revisa los cambios antes de guardarlos
- `/nuevo-sprint` — arranca un período de trabajo con objetivos claros

### [.claude/docs/ways-of-working/](.claude/docs/ways-of-working/README.md) — Reglas de trabajo
Cómo trabajar bien con Claude: quién decide qué, cómo pedir cosas, cuándo
Claude debe parar y consultar, cómo se aprende de los errores, cómo se documentan
las decisiones. Todo en lenguaje normal, sin jerga.

### [.claude/memory/](.claude/memory/README.md) — Memoria entre sesiones
Claude no recuerda conversaciones anteriores por defecto. Esta carpeta es su
memoria persistente: guarda preferencias, contexto y correcciones para que
no haya que repetirlas en cada sesión.

---

## Documentación del proyecto (`docs/`)

> Esta carpeta es para personas, no para Claude. Documenta el proyecto
> de forma que cualquier miembro del equipo (o tú en 6 meses) pueda entenderlo.

### [docs/GETTING-STARTED.md](docs/GETTING-STARTED.md) — Cómo arrancar
Guía paso a paso para empezar desde cero: qué instalar, cómo conectar GitHub,
cómo es el flujo de trabajo diario. Sin conocimientos técnicos previos.

### [docs/DICCIONARIO.md](docs/DICCIONARIO.md) — Glosario técnico
30+ términos técnicos explicados en lenguaje normal: commit, rama, API, hook,
deploy, sprint... Si escuchas una palabra que no entiendes, búscala aquí.

### [docs/ARQUITECTURA.md](docs/ARQUITECTURA.md) — Cómo está construido
Claude mantiene este archivo actualizado con el estado técnico real del proyecto:
qué tecnologías usa, cómo está organizado, qué flujos existen. Para entender
el sistema sin leer código.

### [docs/CHANGELOG.md](docs/CHANGELOG.md) — Historial de cambios
Registro cronológico de qué cambió en el proyecto y cuándo. Claude lo actualiza
con cada cambio significativo.

### [docs/ROADMAP.md](docs/ROADMAP.md) — Hoja de ruta
Qué está planeado construir y en qué orden. El dueño del proyecto define las
prioridades; Claude ayuda a estimar el esfuerzo.

### [docs/decisiones/](docs/decisiones/README.md) — Decisiones importantes
Registro de decisiones técnicas relevantes (ADRs): qué se decidió, por qué,
y qué alternativas se descartaron. Para no repetir debates ya cerrados.

### [docs/sprints/](docs/sprints/README.md) — Registro de sprints
Historial de períodos de trabajo: qué se consiguió en cada sprint, qué quedó
pendiente. Memoria del progreso del proyecto.

---

## GitHub (`.github/`)

Configuración automática para GitHub:
- **CI** — verifica que el código funciona en cada cambio (configurable al stack)
- **PR template** — checklist de revisión antes de aprobar cambios

---

## ¿Esta estructura es mucho?

No tienes que entenderla toda de golpe. Para empezar solo necesitas:
1. `SYSTEM_VISION.md` — rellenarlo con tu proyecto
2. `docs/GETTING-STARTED.md` — seguir los pasos
3. `docs/DICCIONARIO.md` — consultar cuando aparezca algo desconocido

El resto lo gestiona Claude.
