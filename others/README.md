# 📁 Carpeta Others

Esta carpeta contiene archivos de soporte, documentación y recursos adicionales del proyecto. Está organizada en las siguientes subcarpetas:

## 🏗️ `architecture/`

Contiene la documentación visual de la arquitectura del sistema:

- **Diagramas PNG**: Serie de diagramas de arquitectura (a_arquitectura.png hasta i_arquitectura.png) que muestran diferentes vistas y componentes del sistema
- **Archivos DrawIO**:
  - `z_arquitectura.drawio` - Diagrama editable de la arquitectura general
  - `z_langgraph.drawio` - Diagrama específico de LangGraph

Esta carpeta es útil para entender el diseño y la estructura general del proyecto antes de trabajar con el código.

## 💾 `data/`

Contiene los datos persistentes y configuraciones de los servicios de la aplicación:

### Subcarpetas de bases de datos:

- **`budget-mcp-db/`**: Datos de PostgreSQL para la aplicación de presupuestos
- **`documents-app-db/`**: Datos de PostgreSQL para la aplicación de documentos
- **`message-app-db/`**: Datos de PostgreSQL para la aplicación de mensajes
- **`qdrant/`**: Almacenamiento de la base de datos vectorial Qdrant
- **`nginx-files/`**: Archivos de configuración y contenido estático de Nginx

Estas carpetas son montadas como volúmenes por Docker Compose para mantener la persistencia de datos entre reinicios del contenedor.

## 🚀 `start/`

Contiene los scripts y archivos necesarios para la configuración inicial del proyecto:

### Archivos principales:

- **`README.md`**: Guía detallada para el inicio rápido del proyecto
- **Scripts de compresión/descompresión**:
  - `compress.sh` / `compress.ps1` - Comprimen las carpetas de datos en archivos ZIP
  - `uncompress.sh` / `uncompress.ps1` - Descomprimen los archivos ZIP descargados

### Subcarpeta:

- **`downloads/`**: Contiene los archivos ZIP comprimidos de las bases de datos y configuraciones:
  - `budget-mcp-db.zip` (838MB)
  - `documents-app-db.zip` (71MB)
  - `message-app-db.zip` (14MB)
  - `nginx-files.zip` (1.4GB)
  - `qdrant.zip` (73MB)

## 🔄 Flujo de trabajo típico

1. **Primera instalación**: Descargar archivos desde Google Drive → Colocar en `start/downloads/` → Ejecutar script de descompresión → `docker compose up`

2. **Para compartir datos actualizados**: Ejecutar script de compresión → Subir archivos ZIP actualizados a Google Drive

3. **Para restaurar/actualizar datos**: Descargar archivos actualizados → Ejecutar script de descompresión

Esta estructura permite mantener separados los diferentes aspectos del proyecto: documentación técnica, datos persistentes, y herramientas de configuración inicial.
