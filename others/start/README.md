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

Desde el directorio `others/start`, da permisos y ejecuta:

```bash
chmod +x uncompress.sh
./uncompress.sh
```

Esto descomprime los archivos y deja todo listo en `others/data/`.

## 🐳 3. Levantar el Proyecto

Desde la raíz del proyecto:

```bash
docker compose up
```

> Asegúrate de tener **Docker** y **Docker Compose** instalados.

---

## 🧰 Scripts Útiles

### `uncompress.sh`

Descomprime los archivos ZIP del proyecto.

### `compress.sh`

Vuelve a comprimir los datos para compartir o respaldar:

```bash
chmod +x compress.sh
./compress.sh
```

---

## 🔄 Flujo de Trabajo

- **Instalación inicial:** descarga → descomprime → `docker compose up`.
- **Para compartir:** ejecuta `compress.sh` y sube a Drive.
- **Para actualizar:** descarga desde Drive → `uncompress.sh`.
