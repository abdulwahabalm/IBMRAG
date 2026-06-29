# Functional Specification
**Project:** Agentic RAG Blood Test Analysis System  
**Linked to:** REQ-001  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## API Endpoint Specification

### POST /api/blood-test/analyse

**Purpose:** Upload blood test document and receive AI-generated analysis

**Request Schema:**
```json
{
  "document": "base64_encoded_file_content",
  "document_type": "pdf|txt|image",
  "patient_id": "string (optional)"
}
```

**Response Schema:**
```json
{
  "summary": "Overall health assessment text",
  "confidence": "High|Medium|Low",
  "markers": [
    {
      "name": "haemoglobin|whiteBloodCells|ferritin|crp",
      "value": "numeric_value unit",
      "range": "min-max unit",
      "status": "optimal|attention|improving"
    }
  ],
  "recommendations": [
    {
      "title": "Action title",
      "detail": "Detailed recommendation text",
      "icon": "icon_identifier"
    }
  ],
  "disclaimer": "Synthetic data notice",
  "timestamp": "ISO8601 datetime"
}
```

## Business Rules for 4 Markers

| Marker | Normal Range | Status Logic |
|---|---|---|
| **Haemoglobin** | 13.5-17.5 g/dL (M), 12.0-15.5 g/dL (F) | <12: attention, 12-18: optimal, >18: attention |
| **White Blood Cells** | 4.0-11.0 × 10⁹/L | <4: attention, 4-11: optimal, >11: attention |
| **Ferritin** | 30-400 ng/mL (M), 15-150 ng/mL (F) | <30: attention, 30-400: optimal, >400: attention |
| **CRP** | <3.0 mg/L | <1: optimal, 1-3: improving, >3: attention |

## Processing Flow
1. Receive document upload
2. Extract text via OCR/parser
3. Store in ChromaDB vector store
4. Query RAG agent with Ollama (llama3.2)
5. Generate insights with evidence retrieval
6. Return structured JSON response
7. Log audit trail

---
*Note: Demo specification with mock schemas.*