# Solution Design
**Project:** Agentic RAG Blood Test Analysis System  
**Linked to:** REQ-001  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## Architecture Overview (Text-Based)

```
┌─────────────────┐
│  Flutter Mobile │  (Presentation Layer)
│   Application   │  - Upload UI
│                 │  - Results Display
└────────┬────────┘
         │ HTTPS/REST
         ▼
┌─────────────────┐
│  FastAPI Backend│  (API Layer)
│   (Python)      │  - POST /api/blood-test/analyse
│                 │  - Document processing
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  RAG Agent      │  (Intelligence Layer)
│  (Ollama)       │  - llama3.2 model
│                 │  - nomic-embed-text
│                 │  - Context retrieval
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  ChromaDB       │  (Storage Layer)
│  Vector Store   │  - Embeddings storage
│                 │  - Similarity search
└─────────────────┘
```

## Component Interaction

| Component | Responsibility | Technology |
|---|---|---|
| **Flutter Frontend** | User interface, file upload, results visualization | Dart/Flutter |
| **FastAPI Backend** | API endpoints, request validation, orchestration | Python/FastAPI |
| **RAG Agent** | Natural language processing, insight generation | Ollama (llama3.2) |
| **Vector Store** | Document embeddings, semantic search | ChromaDB |

## Data Flow

1. **Upload Phase:** User selects blood test document → Flutter encodes to base64 → POST to FastAPI
2. **Processing Phase:** FastAPI extracts text → Chunks document → Generates embeddings → Stores in ChromaDB
3. **Analysis Phase:** RAG agent queries vector store → Retrieves relevant context → Generates insights with LLM
4. **Response Phase:** FastAPI structures JSON response → Returns to Flutter → UI displays markers and recommendations
5. **Audit Phase:** System logs request metadata → Stores in audit database

## Security & Compliance
- HTTPS encryption for all API calls
- Synthetic data disclaimer on all outputs
- Audit logging for compliance tracking
- No PHI storage (demo environment)

---
*Note: Demo architecture with simplified components.*