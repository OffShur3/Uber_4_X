---
tags: [enero]
other_title: "0-Planeacion"
cssclasses:
  - center-images
  - center-titles
  - page-grid
  - pen-blue
  - tufte
  - recolor-images*
---

----
# martes, 27 de #enero [[2026]]

***
```table-of-contents
title: ## *Indice*
style: nestedList # TOC style (nestedList|inlineFirstLevel)
minLevel: 2 # Include headings from the specified level
maxLevel: 0 # Include headings up to the specified level
includeLinks: true # Make headings clickable
debugInConsole: false # Print debug info in Obsidian console
```
----

## 0-Planeacion
### Idea central del proyecto

La idea central del proyecto es desarrollar una plataforma on-demand para la asignación inmediata de técnicos de oficio verificados (gas, electricidad, plomería), con foco en la urgencia, la seguridad y la trazabilidad del servicio. El objetivo del MVP no es replicar todas las funcionalidades de plataformas consolidadas, sino validar el flujo principal: un usuario con una necesidad urgente solicita un servicio, el sistema asigna un técnico cercano y disponible, el trabajo se realiza y el pago se libera una vez confirmado. Todo lo que no sea estrictamente necesario para ese flujo queda fuera de la primera versión.

### Camino funcional de la aplicación

El camino funcional de la aplicación se define a partir de dos recorridos principales. Del lado del usuario, el flujo es: registro o inicio de sesión, solicitud de un servicio indicando categoría y ubicación, asignación automática de un técnico, seguimiento del estado del servicio, confirmación de finalización y pago. Del lado del técnico, el flujo es: registro, carga de documentación y matrícula, validación por parte del sistema, configuración de disponibilidad, recepción de solicitudes, aceptación o rechazo del trabajo y cierre del servicio. El sistema actúa como intermediario confiable, gestionando estados, validaciones y pagos.

### Roles y responsabilidades del equipo

Para poder avanzar de forma ordenada, se propone una división clara de responsabilidades entre los tres desarrolladores. Un rol estará enfocado en el backend y la lógica central del negocio, encargándose de la API, los estados del servicio, el matching básico por cercanía y la integración de pagos. Otro rol estará orientado al frontend, responsable de la experiencia de usuario tanto para el cliente como para el técnico, priorizando flujos simples y claros acordes a un contexto de urgencia. El tercer rol se orienta a DevSecOps y arquitectura técnica, con responsabilidad sobre las decisiones de stack, la estructura general del sistema, la seguridad desde el inicio, los entornos de desarrollo y despliegue, y la planificación técnica. Este rol también puede aportar código en componentes estructurales y simples, como configuración de entornos, automatizaciones, validaciones básicas y scripts de soporte.

### Alcance del rol DevSecOps y arquitectura

El trabajo del rol DevSecOps incluye definir el marco técnico mínimo antes de escribir funcionalidades complejas. Esto implica establecer una arquitectura inicial simple (monolítica, orientada a API), criterios básicos de seguridad (gestión de credenciales, autenticación, validación de datos), y un flujo de trabajo reproducible para todo el equipo. El objetivo es reducir improvisaciones, evitar retrabajo y asegurar que el proyecto pueda escalar de forma ordenada si el MVP valida la idea.

### Entornos de trabajo y herramientas

En cuanto a los entornos y herramientas, se propone centralizar el desarrollo en un único repositorio GitHub durante la etapa inicial. Se trabajará con una rama principal estable y una rama de desarrollo, utilizando ramas por funcionalidad y pull requests para integrar cambios. No se permitirán commits directos a la rama principal. La gestión de tareas se realizará mediante un tablero Kanban en Notion, con columnas claras (backlog, por hacer, en progreso, revisión y terminado), y cada tarea contará con una breve descripción, criterios de finalización y responsable asignado.

### Entorno de desarrollo y buenas prácticas

El entorno de desarrollo deberá ser homogéneo para todos los integrantes. Se utilizará un archivo de variables de entorno de ejemplo que se compartirá en el repositorio, mientras que los valores reales se mantendrán fuera del control de versiones. El uso de entornos virtuales o gestores de dependencias será obligatorio según el stack elegido, de modo que cualquier integrante pueda levantar el proyecto desde cero siguiendo instrucciones claras. Idealmente, el proyecto contará desde el inicio con una configuración de contenedores que permita ejecutar backend, base de datos y servicios auxiliares de forma consistente en todas las máquinas.

### Objetivo del documento

Este documento no busca cerrar decisiones de manera definitiva, sino proponer un punto de partida técnico y organizativo para comenzar el desarrollo de forma alineada. La intención es acordar un marco común, roles claros y un flujo de trabajo compartido que permita avanzar rápido sin perder orden ni calidad.

## Flujo de trabajo

### Paso 1: Desarrollo Local (cada uno)

```bash
# En su laptop, con el repo clonado
nix develop                    # Entra al entorno
docker compose up -d postgres redis  # Solo infra
pnpm dev                       # Frontend con hot-reload (puerto 5173)
# Backend: pueden correrlo directo con Python para debugging
poetry run uvicorn src.main:app --reload --port 8001

# En su laptop, con el repo clonado
nix develop                    # Entra al entorno
docker compose up -d postgres redis  # Solo infra
pnpm dev                       # Frontend con hot-reload (puerto 5173)
# Backend: pueden correrlo directo con Python para debugging
poetry run uvicorn src.main:app --reload --port 8001
```


**Por qué no `docker compose up -d` completo localmente?**
- Consume muchos recursos en cada máquina
- Hot-reload del frontend es más rápido sin Docker
- Debugging de Python es más fácil nativo

### Paso 2: Cuando el código está listo para probar

```bash
# Suben cambios a Git (GitHub/GitLab)
git add .
git commit -m "feat: add job posting"
git push origin feature/job-posting
```

### Paso 3: CI/CD despliega al servidor compartido

```bash
# En el servidor (automático vía GitHub Actions/GitLab CI)
git pull origin main
docker compose down
docker compose build --no-cache
docker compose up -d
```

**Todos pueden acceder** a: `https://staging.tuapp.com`

***

## Posible Arquitectura Declarativa (Open Source Stack)

Para tu marketplace tipo TaskRabbit, esta es la infraestructura que te dará control total:

- **Base de Datos y Auth: [Supabase](https://supabase.com/docs/guides/self-hosting) (Versión Docker)**
    - **Por qué:** Es la alternativa Open Source a Firebase. Te da PostgreSQL, Autenticación y APIs REST/Realtime automáticamente. Todo se levanta con un `docker-compose.yml`.

- **Backend de Lógica (Python): [FastAPI](https://fastapi.tiangolo.com/)**
    - **Por qué:** Es el estándar moderno para Python. Declarativo por naturaleza (usa Pydantic), extremadamente rápido y fácil de auditar a nivel de seguridad.

- **Frontend (PWA): [FlutterFlow](https://flutterflow.io/) o [Enlightn](https://github.com/enlightn/enlightn)**
    - **Transparencia:** Aunque FlutterFlow es SaaS para diseñar, el código Dart resultante es Open Source y lo puedes compilar tú mismo. Si quieres algo 100% código desde el día 1, **SvelteKit** con un template de PWA es lo más limpio.

- **Orquestación y Proxy: [Traefik](https://traefik.io/) o [Nginx Proxy Manager](https://nginxproxymanager.com/)**
    - **Por qué:** Manejo declarativo de certificados SSL (Let's Encrypt) y enrutamiento de tus contenedores.





----
Links:

****

## Otras anotaciones
