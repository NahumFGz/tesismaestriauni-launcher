# 🧠 Tesis de Maestría UNI – Transparencia Gubernamental con IA Conversacional

Este repositorio contiene el código fuente, datos y configuraciones asociados al desarrollo de la tesis:

**"Desarrollo de un Modelo Conversacional para la Transparencia Gubernamental del Estado Peruano: Integración de Técnicas de Recuperación Aumentada por Generación y Bases de Datos en Contrataciones Públicas y Conducta Parlamentaria"**

El sistema integra procesamiento de documentos públicos, modelos de lenguaje y microservicios coordinados mediante Docker. Permite consultas en lenguaje natural sobre tres dominios clave: **asistencias congresales, votaciones parlamentarias** y **contrataciones públicas**.

---

## ✅ Requisitos mínimos

Para ejecutar correctamente el entorno, se requiere configurar las siguientes **API keys** en tu archivo `.env`:

| Servicio               | Variable de entorno | URL para generar token                      |
| ---------------------- | ------------------- | ------------------------------------------- |
| OpenAI                 | `OPENAI_API_KEY`    | https://platform.openai.com/api-keys        |
| Anthropic (Claude)     | `ANTHROPIC_API_KEY` | https://console.anthropic.com/settings/keys |
| Tavily (búsquedas web) | `TAVILY_API_KEY`    | https://www.tavily.com/                     |

> **Nota:** Actualmente no existe un archivo `.env.template` en el proyecto. Crea tu propio archivo `.env` con las variables mencionadas arriba.

---

## 🗂️ Estructura del Proyecto

### 🎛️ Microservicios y agentes conversacionales

- **`frontend/`**  
  Aplicación React + Vite + TypeScript con TailwindCSS y HeroUI para la interfaz conversacional y visualización de resultados. Incluye integración con Socket.IO para comunicación en tiempo real.

- **`ms-gateway/`**  
  Gateway NestJS que enruta solicitudes vía NATS a los microservicios internos.

- **`ms-messages/`**  
  Microservicio de mensajería basado en Python/FastAPI que integra el protocolo MCP (Model Context Protocol) para la conexión con agentes locales y remotos. Gestiona la generación de respuestas mediante LangGraph.

- **`ms-auth/`**  
  Servicio de autenticación de usuarios desarrollado en NestJS con Prisma ORM.

- **`ms-documents/`**  
  API REST desarrollada en NestJS para gestionar y consultar documentos OCR extraídos, incluyendo filtros por nombre y visualización directa. Utiliza Prisma con PostgreSQL.

- **`mcp-attendance/`**  
  Agente RAG (Retrieval-Augmented Generation) desarrollado en Python que permite consultas sobre **asistencia de congresistas**. Utiliza embeddings, Qdrant y LangGraph.

- **`mcp-voting/`**  
  Agente RAG para **votaciones parlamentarias** desarrollado en Python. Responde con base en evidencia recuperada utilizando Qdrant y técnicas de RAG.

- **`mcp-budget/`**  
  Agente SQL para **contrataciones públicas** desarrollado en Python, que se conecta directamente a bases PostgreSQL. Utiliza herramientas como `sql_db_query` para generar respuestas estructuradas.

---

### 🧪 Entrenamiento y evaluación

- **`train-attendance/`**, **`train-voting/`**, **`train-budget/`**  
  Contienen notebooks Jupyter, scripts Python y configuraciones de entrenamiento y evaluación para cada agente. Incluyen experimentos con métricas como `Recall@k`, `MRR`, `BERTScore`, `SAS`, etc. Utilizan Poetry para gestión de dependencias.

---

### 📊 Extracción y procesamiento de datos públicos

- **`publicdata-scraper/`**  
  Scrapers desarrollados en Python para portales como OSCE, SUNAT, MEF, Congreso de la República, Portal de Transparencia, entre otros. Incluye:

  - `a_asistencia_votaciones/`: Extracción de datos de asistencias y votaciones del Congreso
  - `b_diario_debates/`: Scraping del diario de debates
  - `c_el_peruano/`: Extracción de documentos del Diario Oficial El Peruano
  - `d_transparencia/`: Datos del Portal de Transparencia
  - `e_sunat/`: Información de RUCs de SUNAT
  - `f_osce/`: Datos de contrataciones públicas de OSCE

- **`publicdata-classifier/`**  
  Clasificadores desarrollados en PyTorch que identifican documentos relevantes (asistencias, votaciones, contratos) a partir de texto OCR o metadatos. Incluye experimentos con diferentes arquitecturas (DenseNet, EfficientNet, MobileNet, ResNet, VGG).

- **`publicdata-yolo/`**  
  Anotaciones y configuraciones de entrenamiento para segmentación de zonas clave mediante YOLOv8. Incluye evaluación de modelos OCR (Teseract, EasyOCR, Doctr, PaddleOCR) con métricas CER y WER. Integra Label Studio para anotación de datos.

---

### 🛠️ Archivos y configuración

- **`others/`**

  - `architecture/`: Diagramas y esquemas de arquitectura del sistema en formato DrawIO y GIF:
    - `langgraph.gif`: Flujo de LangGraph
    - `basic.gif`: Arquitectura básica del sistema
    - `others.gif`: Arquitectura con microservicios adicionales
    - `redis.gif`: Arquitectura con Redis
  - `data/`: Respaldos y muestras de bases de datos organizados por servicio
  - `start/`: Scripts de inicialización de bases de datos y volúmenes

- **Archivos de orquestación Docker:**

  - `docker-compose.yml`: Configuración completa del sistema
  - `docker-compose.mcp.yml`: Solo agentes MCP
  - `docker-compose.app.yml`: Solo aplicación frontend y gateway

- **Documentación adicional:**
  - `z-docker-comands.md`: Comandos útiles de Docker y gestión de submódulos Git
  - `z-docker-cheat-sheet.pdf`: Guía de referencia rápida de Docker

---

## 🚀 Inicio rápido

### Prerrequisitos

- Docker y Docker Compose instalados
- Git para clonar el repositorio

### Pasos de instalación

1. **Clonar el repositorio con submódulos:**

```bash
git clone --recursive https://github.com/tu-usuario/tesismaestriauni-launcher.git
cd tesismaestriauni-launcher
```

2. **Inicializar submódulos (si no se hizo con --recursive):**

```bash
git submodule update --init --recursive
```

3. **Configurar variables de entorno minima:**
   - Crea un archivo `.env` en la raíz del proyecto
   - Agrega las siguientes variables con tus API keys:

```env
OPENAI_API_KEY=tu_api_key_aqui
ANTHROPIC_API_KEY=tu_api_key_aqui
TAVILY_API_KEY=tu_api_key_aqui
```

4. **Ejecutar el sistema completo:**

```bash
docker compose up --build
```

### Opciones de despliegue

- **Sistema completo:** `docker compose up --build`
- **Solo agentes MCP:** `docker compose -f docker-compose.mcp.yml up --build`
- **Solo aplicación:** `docker compose -f docker-compose.app.yml up --build`

### Actualización de submódulos

Para actualizar las referencias de los submódulos:

```bash
git submodule update --remote
```

---

## 📝 Notas de desarrollo

- El proyecto utiliza submódulos Git para organizar los diferentes componentes
- Cada microservicio tiene su propio Dockerfile y configuración
- Los notebooks están organizados por funcionalidad específica
- La documentación técnica adicional se encuentra en el directorio `others/`

Para más detalles sobre comandos Docker y gestión del proyecto, consulta el archivo `z-docker-comands.md`.
