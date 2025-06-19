# 🧠 Tesis de Maestría UNI – Transparencia Gubernamental con IA Conversacional

Este repositorio contiene el código fuente, datos y configuraciones asociados al desarrollo de la tesis:

**“Desarrollo de un Modelo Conversacional para la Transparencia Gubernamental del Estado Peruano: Integración de Técnicas de Recuperación Aumentada por Generación y Bases de Datos en Contrataciones Públicas y Conducta Parlamentaria”**

El sistema integra procesamiento de documentos públicos, modelos de lenguaje y microservicios coordinados mediante Docker. Permite consultas en lenguaje natural sobre tres dominios clave: **asistencias congresales, votaciones parlamentarias** y **contrataciones públicas**.

---

## ✅ Requisitos mínimos

Para ejecutar correctamente el entorno, se requiere configurar las siguientes **API keys** en tu archivo `.env`:

| Servicio               | Variable de entorno | URL para generar token                      |
| ---------------------- | ------------------- | ------------------------------------------- |
| OpenAI                 | `OPENAI_API_KEY`    | https://platform.openai.com/api-keys        |
| Anthropic (Claude)     | `ANTHROPIC_API_KEY` | https://console.anthropic.com/settings/keys |
| Tavily (búsquedas web) | `TAVILY_API_KEY`    | https://www.tavily.com/                     |

Copia `.env.template` a `.env` y reemplaza los valores correspondientes.

---

## 🗂️ Estructura del Proyecto

### 🎛️ Microservicios y agentes conversacionales

- **`frontend/`**  
  Aplicación React para la interfaz conversacional y visualización de resultados.

- **`ms-gateway/`**  
  Gateway NestJS que enruta solicitudes vía NATS a los microservicios internos.

- **`ms-messages/`**  
  Microservicio de mensajería que integra el protocolo MCP (Model Context Protocol) para la conexión con agentes locales y remotos. Gestiona la generación de respuestas mediante LangGraph.

- **`ms-auth/`**  
  (En desarrollo) Servicio de autenticación de usuarios.

- **`ms-documents/`**  
  API REST para gestionar y consultar documentos OCR extraídos, incluyendo filtros por nombre y visualización directa.

- **`mcp-attendance/`**  
  Agente RAG (Retrieval-Augmented Generation) que permite consultas sobre **asistencia de congresistas**. Utiliza embeddings, Qdrant y LangGraph.

- **`mcp-voting/`**  
  Agente RAG para **votaciones parlamentarias**. Responde con base en evidencia recuperada.

- **`mcp-budget/`**  
  Agente SQL para **contrataciones públicas**, que se conecta directamente a bases PostgreSQL. Utiliza herramientas como `sql_db_query` para generar respuestas estructuradas.

---

### 🧪 Entrenamiento y evaluación

- **`train-attendance/`**, **`train-voting/`**, **`train-budget/`**  
  Contienen notebooks, scripts y configuraciones de entrenamiento y evaluación para cada agente. Incluyen experimentos con métricas como `Recall@k`, `MRR`, `BERTScore`, `SAS`, etc.

---

### 📊 Extracción y procesamiento de datos públicos

- **`publicdata-scraper/`**  
  Scrapers para portales como OSCE, SUNAT, MEF, Congreso de la República, entre otros.

- **`publicdata-classifier/`**  
  Clasificadores que identifican documentos relevantes (asistencias, votaciones, contratos) a partir de texto OCR o metadatos.

- **`publicdata-yolo/`**  
  Anotaciones y configuraciones de entrenamiento para segmentación de zonas clave mediante YOLOv8. Incluye evaluación de modelos OCR (Doctr, PaddleOCR) con CER y WER.

---

### 🛠️ Archivos y configuración

- **`others/`**

  - `architecture/`: diagramas y esquemas de arquitectura (como la Figura 2 del documento).
  - `data/`: respaldos y muestras de bases de datos.
  - `start/`: scripts de inicialización de bases de datos y volúmenes.

- **`.env`, `.env.template`**  
  Variables de entorno necesarias para levantar el stack.

- **`docker-compose.yml`**, `docker-compose.mcp.yml`, `docker-compose.app.yml`  
  Archivos de orquestación Docker para distintos entornos (todo el sistema, solo MCP, etc).

- **`README.md`**, `z-docker-cheat-sheet.pdf`, `z-docker-comands.md`  
  Documentación complementaria sobre comandos y entorno de despliegue.

---

## 🚀 Inicio rápido

1. Asegúrate de tener Docker y Docker Compose instalados.
2. Crea un archivo `.env` a partir de `.env.template` y configura tus claves API.
3. Ejecuta el siguiente comando:

```bash
docker compose up --build
```
