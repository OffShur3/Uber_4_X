# Uber for X – Documentación de Proyecto y Guía de Arranque

## Descripción

Este repositorio contiene el código y la planeación para construir una plataforma on-demand (tipo "Uber for X") para la asignación inmediata de técnicos de oficio (gasistas, electricistas, plomeros, etc.). El objetivo principal es validar, mediante un MVP, el flujo completo: desde la solicitud del usuario hasta la confirmación del servicio realizado y el pago seguro al técnico.

## Documentación relevante

- Planeación inicial: [READMEs/0-Planeacion_inicial.md](READMEs/0-Planeacion_inicial.md)
- Guía Uber for X, desafíos y recomendaciones: [What is Uber for X Marketplace? The Most Detailed Guide (fatbit.com)](https://www.fatbit.com/fab/uber-for-x/)
- Self-hosting Supabase (PostgreSQL + Auth): [Supabase self-hosting docs](https://supabase.com/docs/guides/self-hosting)
- FastAPI (Python backend): [FastAPI documentation](https://fastapi.tiangolo.com/)
- SvelteKit (frontend base): [SvelteKit docs](https://kit.svelte.dev/)

---

## Requisitos previos

- **Nix** (y nixpkgs). Permite un entorno de desarrollo reproducible y multiplataforma.
- Docker y Docker Compose.
- Opcional: pnpm y poetry (recomendado instalarlos dentro de Nix Shell).

---

## Paso 0: Instalar Nix (si aún no lo tienes)

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```
Este comando instala el gestor de paquetes Nix, necesario para un entorno consistente.

---

## Levantar el entorno de desarrollo

### 1. Ingresar al entorno Nix

Una vez instalado Nix, abre una terminal en la raíz del proyecto y ejecuta:

```bash
nix develop
```
Esto activa un entorno con todas las dependencias necesarias para backend y frontend (Python, Node, Docker, pnpm, poetry, etc).

---

### 2. Instalación de dependencias

Con el entorno Nix activado, corre los siguientes comandos según el stack que quieras levantar:

- **Backend (Python):**
    ```bash
    poetry install
    ```
    Instala todas las dependencias del backend (FastAPI, SQLAlchemy, etc).

- **Frontend (Node/SvelteKit):**
    ```bash
    pnpm install
    ```
    Instala todas las dependencias del frontend.

---

### 3. Levantar los servicios

Dentro del entorno Nix, ejecutar:

```bash
docker compose up -d
```
Esto inicia todos los servicios definidos en `docker-compose.yml`: base de datos, backend, frontend, redis, etc. El flag `-d` los levanta en modo background.

> Para desarrollo más rápido puedes levantar solo los servicios de infraestructura y el frontend nativo (ver la planeación inicial, sección "flujo de trabajo" para detalles).

---

### 4. Levantar el frontend en modo desarrollo

En otra terminal (dentro del mismo entorno Nix):

```bash
pnpm dev
```
Esto activa el modo hot-reload en el frontend, ideal para desarrollo.

---

## Comandos útiles y explicación

| Comando                        | Descripción                                                                                                 |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| `docker compose up -d`         | Levanta todos los servicios definidos en Docker Compose en background (db, backend, frontend, redis, etc).   |
| `poetry install`               | Instala dependencias del backend Python usando Poetry.                                                      |
| `pnpm install`                 | Instala dependencias del frontend (SvelteKit) usando pnpm.                                                  |
| `pnpm dev`                     | Levanta el servidor de frontend en modo desarrollo con hot-reload para cambios en tiempo real.              |

---

## Ciclo de desarrollo sugerido

```bash
nix develop
docker compose up -d postgres redis      # Solo la infraestructura (opcional)
poetry install                          # Instalar dependencias backend
pnpm install                            # Instalar dependencias frontend
pnpm dev                                # Levantar frontend (puerto 5173)
poetry run uvicorn src.main:app --reload --port 8000   # Backend en hot-reload localmente
```

---

## Otros recursos y documentación

- Arquitectura y flujos sugeridos: [READMEs/0-Planeacion_inicial.md](READMEs/0-Planeacion_inicial.md)
- Documentación FastAPI: [https://fastapi.tiangolo.com/](https://fastapi.tiangolo.com/)
- Documentación SvelteKit: [https://kit.svelte.dev/docs](https://kit.svelte.dev/docs)
- Documentación Supabase Self-host: [https://supabase.com/docs/guides/self-hosting](https://supabase.com/docs/guides/self-hosting)

---

## Contribución

Haz fork, trabaja en una rama con nombre descriptivo y abre un pull request explicando tus cambios. Utiliza siempre las ramas de funcionalidad; no hagas commits directos a main.

---

## Notas finales

Este README y el resto de la documentación pueden mejorar a medida que avance el proyecto. Si encuentras mejoras o errores abre un PR o discútelo en el tablero.
