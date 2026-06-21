# Requirements Document
**Project:** Agentic RAG Blood Test Analysis System  
**Document ID:** REQ-DOC-001  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## Primary Requirement

**REQ-001: Blood Test Analysis Integration**  
The Flutter mobile frontend shall connect to the FastAPI backend to upload blood test documents and display AI-generated insights for key blood markers using synthetic data.

## Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| FR-001 | Frontend shall upload blood test documents (PDF/TXT/Image) via POST /api/blood-test/analyse | High |
| FR-002 | Backend shall analyze 4 markers: haemoglobin, whiteBloodCells, ferritin, crp | High |
| FR-003 | System shall display marker values, ranges, and status (optimal/attention/improving) | High |
| FR-004 | System shall provide actionable recommendations per marker | Medium |
| FR-005 | System shall retrieve evidence from RAG vector store (ChromaDB) | High |

## Non-Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| NFR-001 | **Safety Disclaimer:** Display "This analysis uses synthetic data for demonstration only" | Critical |
| NFR-002 | **Clinical Review:** Require "Consult qualified clinician before medical decisions" notice | Critical |
| NFR-003 | **Audit Logging:** Log all analysis requests with timestamp and user context | High |
| NFR-004 | **Response Time:** API shall respond within 5 seconds for standard queries | Medium |

---
*Note: This is demo documentation with mock requirements.*