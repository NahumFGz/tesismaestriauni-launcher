workspace "Government Transparency - Components" "C4 - Component Diagram per Container" {

  model {
    system = softwareSystem "Government Transparency Platform" "Backend microservices and MCP agents" {

      gateway = container "MS Gateway" "API Gateway and WebSocket entry; routes via NATS" "NestJS, Socket.IO, NATS" {
        gateway_chats_gateway = component "ChatsGateway" "WebSocket gateway (/chats), streaming" "NestJS (Socket.IO)"
        gateway_documents_controller = component "DocumentsModule" "REST endpoints and proxy to MS-Documents" "NestJS"
        gateway_nats_client = component "TransportsModule" "NATS client (request/reply, streaming)" "NATS Client"
        gateway_exception_filter = component "ExceptionFilter" "Centralized error handling" "NestJS Filter"
      }

      chats = container "MS Chats" "Orchestrates MCP agents and manages conversations" "Python, FastAPI, LangGraph" {
        chats_api = component "ChatAPI" "Chat endpoints/handlers" "FastAPI Router"
        chats_orchestrator = component "AgentOrchestrator" "LangGraph flows (RAG/SQL), tool-calling" "LangGraph"
        chats_mcp_client = component "MCP Client" "Client for MCP agents (HTTP streamable)" "FastMCP Client"
        chats_repository = component "ChatsRepository" "Conversation/metadata persistence" "PostgreSQL Client"
      }

      documents = container "MS Documents" "OCR documents management and querying" "NestJS, Prisma" {
        documents_api = component "DocumentsAPI" "NATS/REST handlers for documents" "NestJS Controller"
        documents_att_service = component "AttendanceService" "Attendance domain services" "NestJS Service"
        documents_proc_service = component "ProcurementService" "Procurement domain services" "NestJS Service"
        documents_prisma_repo = component "PrismaRepository" "Data access" "Prisma ORM"
      }

      mcp_attendance = container "MCP Attendance" "RAG agent for attendances" "FastMCP, LangGraph, OpenAI" {
        mcp_att_tools = component "Tools" "buscar_documentos_asistencia, obtener_rango_asistencia" "MCP Tools"
        mcp_att_graph = component "RetrieverGraph" "parse → retrieve" "LangGraph"
        mcp_att_qdrant = component "QdrantClient" "Vector search" "Qdrant Client"
      }

      mcp_voting = container "MCP Voting" "RAG agent for parliamentary voting" "FastMCP, LangGraph, OpenAI" {
        mcp_vot_tools = component "Tools" "consultar_votacion, obtener_rango_votaciones" "MCP Tools"
        mcp_vot_graph = component "RetrieverGraph" "parse → retrieve" "LangGraph"
        mcp_vot_qdrant = component "QdrantClient" "Vector search" "Qdrant Client"
      }

      mcp_proc = container "MCP Procurement" "SQL agent for public procurement" "FastMCP, LangGraph, Claude" {
        mcp_proc_tools = component "Tools" "consultar_contrataciones, obtener_tablas_contrataciones" "MCP Tools"
        mcp_proc_graph = component "SQLAgentGraph" "list_tables → get_schema → generate/check/run" "LangGraph"
        mcp_proc_pg = component "PostgresClient" "Connection to procurement DB" "psycopg/PostgreSQL"
      }

      // Dedicated Qdrant instances per MCP (usar tags en la firma)
      qdrant_att = container "Qdrant (Attendance)" "Vector database for attendance" "Qdrant" "Database"
      qdrant_vot = container "Qdrant (Voting)" "Vector database for voting" "Qdrant" "Database"

      // Infra/DB (usar tags en la firma)
      nats = container "NATS" "Message broker for request/reply and streaming" "NATS" "MessageBroker"
      db_chats = container "DB Chats" "Conversations database" "PostgreSQL" "Database"
      db_documents = container "DB Documents" "OCR documents and metadata database" "PostgreSQL" "Database"
      db_procurement = container "DB Procurement" "Public procurement database" "PostgreSQL" "Database"
    }

    // Web Frontend OUTSIDE the main system box
    web_client = softwareSystem "Web Frontend" "React single-page app" {
      web_app = container "Web App" "React app using REST and WebSocket" "React, TypeScript, Vite" {
        frontend_router = component "Router" "Routing, public/protected routes" "React Router"
        frontend_auth_store = component "AuthStore" "Authentication state" "Zustand"
        frontend_api = component "ApiClient" "HTTP client for REST" "Axios"
        frontend_ws = component "WebSocketClient" "WebSocket client" "Socket.IO Client"

        frontend_chat_page = component "ChatPage" "Real-time chat with streaming" "React"
        frontend_attendance_page = component "AttendancePage" "Attendance queries" "React"
        frontend_procurement_page = component "ProcurementPage" "Procurement queries" "React"
        frontend_voting_page = component "VotingPage" "Voting queries" "React"
      }
    }

    // External provider at top-level
    openai = softwareSystem "OpenAI" "LLM and embeddings APIs" {
      openai_api = container "OpenAI API" "Embeddings and LLM endpoints" "SaaS"
    }

    // Web App → Gateway
    frontend_router -> frontend_chat_page "Routes"
    frontend_router -> frontend_attendance_page "Routes"
    frontend_router -> frontend_procurement_page "Routes"
    frontend_router -> frontend_voting_page "Routes"

    frontend_chat_page -> frontend_ws "Send/receive events" "Socket.IO"
    frontend_attendance_page -> frontend_api "Fetch data" "HTTP/REST"
    frontend_procurement_page -> frontend_api "Fetch data" "HTTP/REST"
    frontend_voting_page -> frontend_api "Fetch data" "HTTP/REST"

    frontend_ws -> gateway_chats_gateway "WS /chats (streaming)" "Socket.IO"
    frontend_api -> gateway_documents_controller "Calls API /api/*" "HTTP/REST"

    // Gateway → NATS
    gateway_chats_gateway -> gateway_nats_client "Publish/request events" "NATS"
    gateway_documents_controller -> gateway_nats_client "Request/Reply to services" "NATS"
    gateway_nats_client -> nats "Uses broker" "NATS"

    // NATS → services
    nats -> chats_api "Request/Reply for chat" "NATS"
    nats -> documents_api "Request/Reply for documents" "NATS"

    // MS Chats
    chats_api -> chats_orchestrator "Invoke flows" ""
    chats_orchestrator -> chats_mcp_client "Invoke MCP tools" "HTTP"
    chats_api -> chats_repository "Read/write history" ""
    chats_repository -> db_chats "CRUD conversations" "SQL"

    // MS Documents
    documents_api -> documents_att_service "Attendance logic" ""
    documents_api -> documents_proc_service "Procurement logic" ""
    documents_att_service -> documents_prisma_repo "Data access" ""
    documents_proc_service -> documents_prisma_repo "Data access" ""
    documents_prisma_repo -> db_documents "Queries/CRUD" "SQL"

    // MCP data dependencies
    chats_mcp_client -> mcp_att_tools "Call tools (attendance)" "HTTP (MCP)"
    chats_mcp_client -> mcp_vot_tools "Call tools (voting)" "HTTP (MCP)"
    chats_mcp_client -> mcp_proc_tools "Call tools (procurement)" "HTTP (MCP)"

    mcp_att_graph -> mcp_att_qdrant "Retrieve" "HTTP"
    mcp_vot_graph -> mcp_vot_qdrant "Retrieve" "HTTP"
    mcp_proc_pg -> db_procurement "Run SQL" "SQL"

    // Dedicated Qdrant links
    mcp_att_qdrant -> qdrant_att "Uses dedicated vector store" ""
    mcp_vot_qdrant -> qdrant_vot "Uses dedicated vector store" ""

    // OpenAI usage
    mcp_att_graph -> openai_api "Embeddings and LLM calls" "HTTPS"
    mcp_vot_graph -> openai_api "Embeddings and LLM calls" "HTTPS"
    chats_orchestrator -> openai_api "LLM calls (generation/assist)" "HTTPS"
    mcp_proc_graph -> openai_api "LLM calls (SQL generation/validation)" "HTTPS"
  }

  views {

  container system "containers-backend" {
    include *
    autoLayout lr
  }

  container web_client "containers-web-frontend" {
    include *
    autoLayout lr
  }

  component web_app "components-frontend" {
    include *
    autoLayout lr
  }

  component gateway "components-gateway" {
    include *
    autoLayout lr
  }

  component chats "components-ms-chats" {
    include *
    autoLayout lr
  }

  component documents "components-ms-documents" {
    include *
    autoLayout lr
  }

  component mcp_attendance "components-mcp-attendance" {
    include *
    autoLayout lr
  }

  component mcp_voting "components-mcp-voting" {
    include *
    autoLayout lr
  }

  component mcp_proc "components-mcp-procurement" {
    include *
    autoLayout lr
  }

  styles {
    element "Container" {
      shape RoundedBox
    }
    element "Component" {
      shape Component
    }
    element "Database" {
      shape Cylinder
    }
    element "MessageBroker" {
      shape Pipe
    }
  }
}
}