# 🚀 Inicio Rápido del Proyecto

Este proyecto usa Docker y requiere algunos archivos previos. Sigue estos pasos para configurarlo.

## 📥 1. Descargar Archivos Requeridos

Descarga los siguientes archivos desde Google Drive:

🔗 [**Descargar archivos del proyecto**](https://drive.google.com/drive/u/1/folders/1RmbKJQyo1lSOLUPrcShYDwktmmu1OLp2)

Colócalos en:

```
others/start/downloads/
├── budget-mcp-db.zip
├── documents-app-db.zip
├── message-app-db.zip
├── nginx-files.zip
└── qdrant.zip
```

## 📦 2. Preparar los Datos

Ejecuta el script para **descomprimir** los archivos ZIP en `others/data/`:

### 🐧 Linux / macOS

```bash
chmod +x uncompress.sh
./uncompress.sh
```

### 🪟 Windows

Puedes usar cualquiera de estas opciones:

**Opción 1: Git Bash (recomendado)**

```bash
chmod +x uncompress.sh
./uncompress.sh
```

**Opción 2: Descompresión manual**

- Descomprime cada archivo ZIP de `others/start/downloads/` en `others/data/`
- Asegúrate de mantener la estructura de carpetas correcta

## 🐳 3. Levantar el Proyecto

Desde la raíz del proyecto:

```bash
docker compose up
```

> Asegúrate de tener **Docker** y **Docker Compose** instalados.

## 🧰 Scripts Útiles

### 🔓 Descompresión

- `uncompress.sh` – Linux/macOS/Windows (Git Bash)

Descomprime los archivos ZIP descargados en `others/data`.

### 🗜️ Compresión

- `compress.sh` – Linux/macOS/Windows (Git Bash)

Vuelve a comprimir las carpetas de `others/data` en ZIP para compartir o respaldar:

```bash
chmod +x compress.sh
./compress.sh
```

## 🔄 Flujo de Trabajo

- **Instalación inicial:** descarga → descomprime (`uncompress.sh` o manualmente) → `docker compose up`
- **Para compartir datos:** ejecuta el script de compresión (`compress.sh`) y sube a Drive
- **Para restaurar datos:** descarga desde Drive → descomprime con el script o manualmente
