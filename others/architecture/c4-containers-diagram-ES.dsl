workspace "Sistema de Transparencia Gubernamental" "Sistema de IA conversacional para datos de transparencia gubernamental" {

    model {
        # External actors
        user = person "Usuario Final" "Ciudadanos consultando datos gubernamentales" "User"
        llmAPI = softwareSystem "API LLM" "Servicio de modelos GPT de OpenAI y embeddings" "External"

        # Main system
        transparencySystem = softwareSystem "Sistema de Transparencia Gubernamental" "Plataforma conversacional impulsada por IA para consultas de datos gubernamentales" {
            
            # User interface
            webApp = container "Aplicación Web" "Interfaz conversacional" "React" "Web"
            
            # Core orchestration
            orchestrator = container "Orquestador de IA" "Coordina agentes especializados y gestiona conversaciones" "Python + LangGraph" "Service"
            
            # Specialized agents
            ragAgents = container "Agentes RAG" "Agentes de consulta de asistencia y votación con búsqueda vectorial" "Python + RAG" "Agent"
            
            sqlAgent = container "Agente SQL" "Agente de consulta de datos de adquisiciones" "Python + SQL" "Agent"
            
            # Data layer
            vectorDB = container "Base de Datos Vectorial" "Embeddings para datos de asistencia y votación" "Qdrant" "VectorDatabase"
            
            relationalDB = container "Base de Datos Relacional" "Datos de adquisiciones e historial de chat" "PostgreSQL" "Database"
        }

        # User interactions
        user -> webApp "Consultas en lenguaje natural" "HTTPS"
        
        # Core system flow
        webApp -> orchestrator "Procesamiento de consultas y generación de respuestas" "HTTP"
        
        # Agent coordination
        orchestrator -> ragAgents "Consultas de asistencia y votación" "MCP"
        orchestrator -> sqlAgent "Consultas de adquisiciones" "MCP"
        
        # Data access
        ragAgents -> vectorDB "Búsqueda semántica" "HTTP"
        sqlAgent -> relationalDB "Consultas SQL" "SQL"
        orchestrator -> relationalDB "Persistencia de chat" "SQL"
        
        # LLM integration
        ragAgents -> llmAPI "Embeddings y generación" "HTTPS"
        sqlAgent -> llmAPI "Comprensión de consultas" "HTTPS"
        orchestrator -> llmAPI "Síntesis de respuestas" "HTTPS"
    }

    views {
        container transparencySystem "Sistema_de_Transparencia_Gubernamental" {
            include *
            autoLayout tb
            title "Sistema de Transparencia Gubernamental"
            description "Sistema conversacional impulsado por IA para consultar datos de transparencia gubernamental"
        }

        styles {
            element "User" {
                background #1168bd
                color #ffffff
                shape Person
            }
            element "External" {
                background #999999
                color #ffffff
            }
            element "Web" {
                background #1168bd
                color #ffffff
                shape WebBrowser
            }
            element "Service" {
                background #85bbf0
                color #ffffff
            }
            element "Agent" {
                background #52b788
                color #ffffff
            }
            element "Database" {
                background #023047
                color #ffffff
                shape Cylinder
            }
            element "VectorDatabase" {
                background #8ecae6
                color #000000
                shape Cylinder
            }
        }

        theme default
    }

    configuration {
        scope softwaresystem
    }
}
