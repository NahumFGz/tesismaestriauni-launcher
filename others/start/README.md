# Configuración del Proyecto

Este directorio contiene los scripts necesarios para gestionar los datos del proyecto y preparar el entorno de desarrollo.

## Descarga de Archivos Requeridos

Antes de ejecutar el proyecto, debes descargar los archivos necesarios desde Google Drive:

**📁 [Descargar archivos del proyecto](https://drive.google.com/drive/u/1/folders/1RmbKJQyo1lSOLUPrcShYDwktmmu1OLp2)**

### Archivos a descargar:

- **`budget-mcp-db.zip`** - Base de datos del sistema de presupuestos
- **`documents-app-db.zip`** - Base de datos del sistema de documentos
- **`message-app-db.zip`** - Base de datos del sistema de mensajería
- **`nginx-files.zip`** - Imagenes de asistencia y votación
- **`qdrant.zip`** - Base de datos vectorial Qdrant

### Ubicación de los archivos:

Coloca todos los archivos ZIP descargados en el directorio `downloads/` dentro de esta carpeta:

```
others/start/downloads/
├── budget-mcp-db.zip
├── documents-app-db.zip
├── message-app-db.zip
├── nginx-files.zip
└── qdrant.zip
```

## Scripts Disponibles

### 🔓 `uncompress.sh` - Descomprimir datos

Este script descomprime todos los archivos ZIP y los prepara para el uso del proyecto.

**Propósito:** Preparar el entorno de desarrollo descomprimiendo las bases de datos y archivos de configuración.

**Uso:**

```bash
chmod +x uncompress.sh
./uncompress.sh
```

**Qué hace:**

- Descomprime cada archivo ZIP en una carpeta con su nombre correspondiente
- Coloca los datos en `others/data/`
- Crea la estructura necesaria para que el proyecto funcione

### 🔒 `compress.sh` - Comprimir datos

Este script comprime los datos actuales para compartir o hacer backup.

**Propósito:** Crear archivos ZIP de los datos actuales para compartir con otros desarrolladores o hacer respaldos.

**Uso:**

```bash
chmod +x compress.sh
./compress.sh
```

**Qué hace:**

- Comprime cada directorio de datos en archivos ZIP
- Guarda los archivos comprimidos en `downloads/`
- Útil para compartir cambios en los datos con el equipo

## Ejecución del Proyecto

### Requisitos Previos

- **Docker** y **Docker Compose** instalados en tu sistema
- Haber ejecutado `uncompress.sh` para preparar los datos

### Pasos para ejecutar:

1. **Descomprimir los datos** (solo la primera vez):

   ```bash
   cd others/start
   ./uncompress.sh
   ```

2. **Ejecutar el proyecto** desde la raíz del repositorio:
   ```bash
   cd /Volumes/Projects/GitHubProjects/tesismaestriauni-launcher
   docker compose up
   ```

## Flujo de Trabajo Recomendado

1. **Primera configuración:**

   - Descargar archivos desde Google Drive
   - Colocarlos en `downloads/`
   - Ejecutar `uncompress.sh`
   - Ejecutar `docker compose up`

2. **Para compartir cambios:**

   - Ejecutar `compress.sh`
   - Subir los archivos ZIP actualizados a Google Drive

3. **Para recibir cambios:**
   - Descargar archivos actualizados desde Google Drive
   - Ejecutar `uncompress.sh`
   - Reiniciar con `docker compose up`

---

**Nota:** Asegúrate de tener Docker y Docker Compose instalados antes de ejecutar el proyecto.
