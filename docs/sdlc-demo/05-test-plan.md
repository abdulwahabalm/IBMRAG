# Test Plan
**Project:** Agentic RAG Blood Test Analysis System  
**Linked to:** REQ-001  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## Test Cases

| Test ID | Description | Test Type | Expected Result | Linked to |
|---|---|---|---|---|
| **TC-001** | Valid blood test upload (PDF format) | Functional | API returns 200, analysis with 4 markers displayed | US-001, FR-001 |
| **TC-002** | Invalid file format upload (DOCX) | Negative | API returns 400 error, user sees "Unsupported format" message | US-001, FR-001 |
| **TC-003** | Disclaimer display verification | UI/Safety | "Synthetic data for demo only" and "Consult clinician" notices visible before and after analysis | US-002, NFR-001, NFR-002 |
| **TC-004** | Evidence retrieval from RAG | Integration | System retrieves relevant context from ChromaDB, confidence score included in response | US-003, FR-005 |
| **TC-005** | Audit logging verification | Compliance | All analysis requests logged with timestamp, user ID, document ID in audit database | US-004, NFR-003 |
| **TC-006** | API error handling (backend unavailable) | Error Handling | Frontend displays "Service temporarily unavailable" with retry option | FR-001, NFR-004 |

## Test Execution Summary

**Test Environment:**
- Frontend: Flutter (iOS/Android simulators)
- Backend: FastAPI (local development server)
- Database: ChromaDB (in-memory for testing)
- LLM: Ollama llama3.2 (local instance)

**Test Data:**
- Sample blood test documents in `backend/samples/`
- Mock patient IDs: patient_001, patient_002, patient_003
- Synthetic marker values within and outside normal ranges

**Pass Criteria:**
- All 6 test cases must pass
- Response time <5 seconds for TC-001
- Zero PHI exposure in logs (TC-005)
- Disclaimers visible in 100% of test runs (TC-003)

## Test Schedule
- Unit Tests: Automated via pytest (backend) and Flutter test (frontend)
- Integration Tests: Manual execution of TC-001 through TC-006
- UAT: Demo with stakeholders using synthetic data

---
*Note: Demo test plan with mock test cases.*