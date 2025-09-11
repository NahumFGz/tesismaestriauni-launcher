workspace "Government Transparency System" "Conversational AI system for government transparency data" {

    model {
        # External actors
        user = person "End User" "Citizens querying government data" "User"
        llmAPI = softwareSystem "LLM API" "OpenAI GPT models and embeddings service" "External"

        # Main system
        transparencySystem = softwareSystem "Government Transparency System" "AI-powered conversational platform for government data queries" {
            
            # User interface
            webApp = container "Web Application" "Conversational interface" "React" "Web"
            
            # Core orchestration
            orchestrator = container "AI Orchestrator" "Coordinates specialized agents and manages conversations" "Python + LangGraph" "Service"
            
            # Specialized agents
            ragAgents = container "RAG Agents" "Attendance and voting query agents with vector search" "Python + RAG" "Agent"
            
            sqlAgent = container "SQL Agent" "Procurement data query agent" "Python + SQL" "Agent"
            
            # Data layer
            vectorDB = container "Vector Database" "Embeddings for attendance and voting data" "Qdrant" "VectorDatabase"
            
            relationalDB = container "Relational Database" "Procurement data and chat history" "PostgreSQL" "Database"
        }

        # User interactions
        user -> webApp "Natural language queries" "HTTPS"
        
        # Core system flow
        webApp -> orchestrator "Query processing and response generation" "HTTP"
        
        # Agent coordination
        orchestrator -> ragAgents "Attendance and voting queries" "MCP"
        orchestrator -> sqlAgent "Procurement queries" "MCP"
        
        # Data access
        ragAgents -> vectorDB "Semantic search" "HTTP"
        sqlAgent -> relationalDB "SQL queries" "SQL"
        orchestrator -> relationalDB "Chat persistence" "SQL"
        
        # LLM integration
        ragAgents -> llmAPI "Embeddings and generation" "HTTPS"
        sqlAgent -> llmAPI "Query understanding" "HTTPS"
        orchestrator -> llmAPI "Response synthesis" "HTTPS"
    }

    views {
        container transparencySystem "Government_Transparency_System" {
            include *
            autoLayout tb
            title "Government Transparency System"
            description "AI-powered conversational system for querying government transparency data"
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
