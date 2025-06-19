# Tesis maestría UNI

frontend: carpeta de frontend del proyecto
mcp-attendance: contiene el codigo del mcp de asistencias del congreso
mcp-voting: contiene el codigo del mcp de votaciones del congreso
mcp-budget: contiene e l codigo del mcp de presupuestos/contrataciones/ordenes de servicios/contratos

ms-documents: contiene el microservicio de documentos, donde se crean las apis de la obtencion de filtrado de documentos por nombre y se puede ver el documento
ms-messages: contiene el microservicio de mensajeria y el modulo de langraph con la conexión a los agentes locales y remotos
ms-gateway: contiene el gateway para la conexión con nats y los microservicios internos

others: carpeta q contiene la arquitectura, datos de la base de daos y los scripts para poder inicializar las bds

publicdata-scraper: contiene los scripts para poder scrapaer los servicios de osce, sunat, transparencia, portal del congreso, etc.
publicdata-classifier: contiene los datos de entrenamiento y validacion para seleccionar los documentos de interes (asistencia, votacion y otros)
publicdata-yolo: contiene los datos de entrenamiento de yolo para poder obtener las regiones de interés, ademas de la validacion de CER Y WER de los OCRs

train-attendance: contiene los experimentos de entrenamiento del mcp de asistencias
train-voting: contiene los experimentos de entrenamiento del mcp de votación
train-budget:contiene los experimentos de entrenamiento del mcp de presupuestos/contratacione/ordenes de servicios/contratos
