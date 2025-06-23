# 📁 Carpeta Others

Esta carpeta contiene archivos de soporte, documentación y recursos adicionales del proyecto. Está organizada en las siguientes subcarpetas:

## 🏗️ `architecture/`

Contiene la documentación visual de la arquitectura del sistema:

- **Diagramas GIF**: Representaciones visuales exportadas de los diagramas de arquitectura

  - `basic.gif` - Diagrama básico de la arquitectura del sistema
  - `langgraph.gif` - Arquitectura de los agentes con LangGraph
  - `other.gif` - Ejemplo de cómo agregar microservicios
  - `redis.gif` - Ejemplo de cómo escalar con Redis

- **Archivos DrawIO editables**:
  - `z_basic.drawio` - Diagrama básico de la arquitectura del sistema
  - `z_langgraph.drawio` - Arquitectura de los agentes con LangGraph
  - `z_other.drawio` - Ejemplo de cómo agregar microservicios
  - `z_redis.drawio` - Ejemplo de cómo escalar con Redis

Esta carpeta es útil para entender el diseño y la estructura general del proyecto antes de trabajar con el código.

## 💾 `data/`

Contiene los datos persistentes y configuraciones de los servicios de la aplicación:

### Subcarpetas de bases de datos:

- **`chat-app-db/`**: Datos de PostgreSQL para la aplicación de chats
- **`documents-app-db/`**: Datos de PostgreSQL para la aplicación de documentos
- **`procurement-mcp-db/`**: Datos de PostgreSQL para la aplicación de procurement/adquisiciones
- **`db-qdrant/`**: Almacenamiento de la base de datos vectorial Qdrant
- **`nginx-files/`**: Archivos de configuración y contenido estático de Nginx

Estas carpetas son montadas como volúmenes por Docker Compose para mantener la persistencia de datos entre reinicios del contenedor.

## 🚀 `start/`

Contiene los scripts y archivos necesarios para la configuración inicial del proyecto:

### Archivos principales:

- **`README.md`**: Guía detallada para el inicio rápido del proyecto
- **Scripts de compresión/descompresión**:
  - `compress.sh` - Comprime las carpetas de datos en archivos ZIP
  - `uncompress.sh` - Descomprime los archivos ZIP descargados

### Subcarpeta:

- **`downloads/`**: Contiene los archivos ZIP comprimidos de las bases de datos y configuraciones:
  - `chat-app-db.zip` (6.9MB)
  - `documents-app-db.zip` (68MB)
  - `procurement-mcp-db.zip` (826MB)
  - `db-qdrant.zip` (73MB)
  - `nginx-files.zip` (1.4GB)

## 🔄 Flujo de trabajo típico

1. **Primera instalación**: Descargar archivos desde Google Drive → Colocar en `start/downloads/` → Ejecutar script de descompresión → `docker compose up`

2. **Para compartir datos actualizados**: Ejecutar script de compresión → Subir archivos ZIP actualizados a Google Drive

3. **Para restaurar/actualizar datos**: Descargar archivos actualizados → Ejecutar script de descompresión

Esta estructura permite mantener separados los diferentes aspectos del proyecto: documentación técnica, datos persistentes, y herramientas de configuración inicial.
