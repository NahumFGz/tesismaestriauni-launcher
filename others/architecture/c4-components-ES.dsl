workspace "Plataforma de Transparencia Gubernamental" "Arquitectura de microservicios y agentes MCP." {

    model {
        frontend = softwareSystem "Web en React" "Aplicación de una sola página (SPA) en React." "Sistema Externo"
        openai = softwareSystem "OpenAI" "APIs de LLM y embeddings." "Sistema Externo"

        platform = softwareSystem "Plataforma de Transparencia Gubernamental" "Sistema central de la plataforma." {
            
            gateway = container "MS Gateway" "API Gateway y entrada WebSocket; enruta vía NATS." "NestJS, Socket.IO, NATS"
            nats = container "NATS" "Broker de mensajes para petición/respuesta y streaming." "NATS" "Message Broker"
            msDocs = container "MS Documentos" "Gestión y consulta de documentos OCR." "NestJS, Prisma"
            msChats = container "MS Chats" "Orquesta agentes MCP y gestiona conversaciones." "Python, FastAPI, LangGraph"
            
            dbDocs = container "BD Documentos" "Base de datos de metadatos y documentos OCR." "PostgreSQL" "Database"
            dbChats = container "BD Chats" "Base de datos de conversaciones." "PostgreSQL" "Database"
            
            mcpAtt = container "MCP Asistencia" "Agente RAG para asistencias." "FastMCP, LangGraph, OpenAI"
            mcpVote = container "MCP Votación" "Agente RAG para votación parlamentaria." "FastMCP, LangGraph, OpenAI"
            mcpProc = container "MCP Contrataciones" "Agente SQL para contrataciones públicas." "FastMCP, LangGraph, Claude"
            
            qdrantAtt = container "Qdrant (Asistencia)" "Base de datos vectorial para asistencia." "Qdrant" "Database"
            qdrantVote = container "Qdrant (Votación)" "Base de datos vectorial para votación." "Qdrant" "Database"
            dbProc = container "BD Contrataciones" "Base de datos de contrataciones públicas." "PostgreSQL" "Database"
        }

        # Relaciones
        frontend -> gateway "WS /chats (streaming)" "Socket.IO"
        gateway -> nats "Usa broker" "NATS"
        
        nats -> msDocs "Petición/Respuesta para documentos" "NATS"
        nats -> msChats "Petición/Respuesta para chat" "NATS"
        
        msDocs -> dbDocs "Consultas/CRUD" "SQL"
        
        msChats -> mcpAtt "Llamada a herramientas (asistencia)" "HTTP (MCP)"
        msChats -> dbChats "CRUD de conversaciones" "SQL"
        msChats -> mcpVote "Llamada a herramientas (votación)" "HTTP (MCP)"
        msChats -> mcpProc "Llamada a herramientas (contrataciones)" "HTTP (MCP)"
        msChats -> openai "Llamadas LLM (generación/asistencia)" "HTTPS"

        mcpAtt -> qdrantAtt "Usa BD vectorial dedicada" "TCP"
        mcpAtt -> openai "Embeddings y llamadas LLM" "HTTPS"
        
        mcpVote -> qdrantVote "Usa BD vectorial dedicada" "TCP"
        mcpVote -> openai "Embeddings y llamadas LLM" "HTTPS"
        
        mcpProc -> dbProc "Ejecuta SQL" "SQL"
        mcpProc -> openai "Llamadas LLM (generación/validación de SQL)" "HTTPS"
    }

    views {
        container platform "Contenedores_Plataforma_Transparencia" {
            include *
            autoLayout tb
        }
        
        styles {
            element "Software System" {
                background #E0E0E0
                color #000000
            }
            element "Container" {
                background #82B1FF
                color #ffffff
            }
            element "Message Broker" {
                shape Pipe
                background #FF9800
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