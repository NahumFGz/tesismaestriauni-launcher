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

Dependiendo de tu sistema operativo, ejecuta el script correspondiente para **descomprimir** los archivos ZIP en `others/data/`:

### 🐧 Linux / macOS

```bash
chmod +x uncompress.sh
./uncompress.sh
```

### 🪟 Windows (PowerShell)

```powershell
cd .\others\start\
.\uncompress.ps1
```

## 🐳 3. Levantar el Proyecto

Desde la raíz del proyecto:

```bash
docker compose up
```

> Asegúrate de tener **Docker** y **Docker Compose** instalados.

## 🧰 Scripts Útiles

### 🔓 Descompresión

- `uncompress.sh` – Linux/macOS
- `uncompress.ps1` – Windows

Descomprime los archivos ZIP descargados en `others/data`.

### 🗜️ Compresión

- `compress.sh` – Linux/macOS
- `compress.ps1` – Windows

Vuelve a comprimir las carpetas de `others/data` en ZIP para compartir o respaldar:

#### Linux/macOS:

```bash
chmod +x compress.sh
./compress.sh
```

#### Windows:

```powershell
cd .\others\start\
.\compress.ps1
```

## 🔄 Flujo de Trabajo

- **Instalación inicial:** descarga → descomprime (`uncompress.sh` o `uncompress.ps1`) → `docker compose up`
- **Para compartir datos:** ejecuta el script de compresión (`compress.sh` o `compress.ps1`) y sube a Drive
- **Para restaurar datos:** descarga desde Drive → descomprime con el script correspondiente
