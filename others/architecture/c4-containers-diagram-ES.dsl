workspace "Sistema de Transparencia Gubernamental" "Diagrama de arquitectura del sistema de consultas ciudadanas." {

    model {
        user = person "Usuario Final" "Ciudadanos consultando datos del gobierno." "Persona"
        
        llm = softwareSystem "API de LLM" "Modelos GPT de OpenAI y servicio de embeddings." "Sistema Externo"
        
        govSystem = softwareSystem "Sistema de Transparencia Gubernamental" "Plataforma principal para la transparencia." {
            webApp = container "Aplicación Web" "Interfaz conversacional." "React" "Web Browser"
            orchestrator = container "Orquestador de IA" "Coordina agentes especializados y gestiona conversaciones." "Python + LangGraph"
            ragAgents = container "Agentes RAG" "Agentes de consulta de asistencia y votación con búsqueda vectorial." "Python + RAG"
            sqlAgent = container "Agente SQL" "Agente de consulta de datos de contrataciones." "Python + SQL"
            relationalDb = container "Base de Datos Relacional" "Datos de contrataciones e historial de chat." "PostgreSQL" "Database"
            vectorDb = container "Base de Datos Vectorial" "Embeddings para datos de asistencia y votación." "Qdrant" "Database"
        }

        # Relaciones
        user -> webApp "Consultas en lenguaje natural" "HTTPS"
        webApp -> orchestrator "Procesamiento de consultas y generación de respuestas" "HTTP"
        
        orchestrator -> ragAgents "Consultas de asistencia y votación" "MCP"
        orchestrator -> sqlAgent "Consultas de contrataciones" "MCP"
        orchestrator -> relationalDb "Persistencia de chat" "SQL"
        orchestrator -> llm "Comprensión de consultas y Síntesis de respuestas" "HTTPS"
        
        ragAgents -> vectorDb "Búsqueda semántica" "HTTP"
        ragAgents -> llm "Embeddings y generación" "HTTPS"
        
        sqlAgent -> relationalDb "Consultas SQL" "SQL"
    }

    views {
        container govSystem "Contenedores_Sistema_Transparencia" {
            include *
            autoLayout tb
        }
        
        styles {
            element "Person" {
                background #1565C0
                color #ffffff
                shape Person
            }
            element "Software System" {
                background #9E9E9E
                color #ffffff
            }
            element "Container" {
                background #1976D2
                color #ffffff
            }
            element "Database" {
                shape Cylinder
                background #001F3F
                color #ffffff
            }
        }
    }
}