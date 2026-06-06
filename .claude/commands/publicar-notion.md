---
name: publicar-notion
description: Escribe el briefing ejecutivo de la semana en una pagina de Notion para que todo el equipo directivo lo vea sin necesitar acceso a Claude.
---

# Comando: /publicar-notion

Genera el briefing ejecutivo completo y lo publica en Notion como una pagina del equipo.

## Proceso

1. Genera el briefing completo igual que /briefing (lee sprint activo, tareas, objetivos)
2. Busca en Notion la seccion "Objetivos, proyectos y tareas" o una pagina de briefings del equipo
3. Crea una nueva pagina con el titulo: "Briefing Ejecutivo — [fecha]"
4. Escribe el contenido del briefing en esa pagina

## Estructura de la pagina en Notion

```
# Briefing Ejecutivo — [dia] [fecha]

Generado por el Agente Ejecutivo de Antifragil

---

## Estado del Sprint [N]
[Tabla de estados]

## Alertas activas
[Lista de alertas]

## En curso
[Tareas DOING]

## Objetivos [trimestre]
[Tabla de objetivos]

## Recomendaciones
[Lista de recomendaciones]

---
Proxima actualizacion: lunes [fecha proximo sprint]
```

## Despues de publicar

Confirma a Fernando:
"Briefing publicado en Notion: [enlace a la pagina]
El equipo puede verlo directamente en su workspace."

## Nota

Si no existe una pagina de briefings del equipo, crea la primera en la raiz de "Objetivos, proyectos y tareas" con el nombre "Briefings Ejecutivos" y anida el briefing ahi dentro.
