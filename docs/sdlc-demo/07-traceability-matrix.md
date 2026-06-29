# Traceability Matrix
**Project:** Agentic RAG Blood Test Analysis System  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## Complete Traceability: REQ-001 → User Stories → Test Cases → Defects/Changes

| Requirement | User Story | Test Case | Defect/Change | Status |
|---|---|---|---|---|
| **REQ-001** | US-001 (Upload) | TC-001 (Valid upload) | - | ✅ Pass |
| REQ-001 | US-001 (Upload) | TC-002 (Invalid format) | - | ✅ Pass |
| REQ-001 | US-002 (View markers) | TC-001 (Valid upload) | DEF-002 (CRP logic) | ⚠️ Open |
| REQ-001 | US-002 (View markers) | TC-003 (Disclaimer) | DEF-001 (CSS overflow) | ✅ Fixed |
| REQ-001 | US-003 (Recommendations) | TC-004 (Evidence retrieval) | CR-001 (Confidence score) | 🔄 Planned |
| REQ-001 | US-004 (Audit trail) | TC-005 (Audit logging) | - | ✅ Pass |
| REQ-001 | - | TC-006 (Error handling) | - | ✅ Pass |

## Functional Requirements Coverage

| Functional Req | Linked User Stories | Test Coverage | Notes |
|---|---|---|---|
| FR-001 (Upload API) | US-001 | TC-001, TC-002, TC-006 | 100% covered |
| FR-002 (4 markers) | US-002 | TC-001 | DEF-002 affects CRP marker |
| FR-003 (Display status) | US-002 | TC-001, TC-003 | DEF-001 fixed |
| FR-004 (Recommendations) | US-003 | TC-004 | CR-001 enhancement planned |
| FR-005 (RAG retrieval) | US-003 | TC-004 | Working as expected |

## Non-Functional Requirements Coverage

| Non-Functional Req | Test Coverage | Compliance Status |
|---|---|---|
| NFR-001 (Synthetic data disclaimer) | TC-003 | ✅ Verified (post DEF-001 fix) |
| NFR-002 (Clinician review notice) | TC-003 | ✅ Verified |
| NFR-003 (Audit logging) | TC-005 | ✅ Verified |
| NFR-004 (Response time <5s) | TC-001 | ✅ Verified (avg 3.2s) |

## Change Impact Analysis

**CR-001 Impact:**
- Affects: US-002, US-003, FR-004
- New test case required: TC-007 (Confidence score validation)
- Documentation updates: Functional spec, API docs
- No impact on existing defects

## Coverage Summary
- **Requirements Coverage:** 100% (REQ-001 fully traced)
- **User Stories Coverage:** 100% (4/4 stories tested)
- **Test Execution:** 83% pass rate (5/6 passed, 1 blocked by DEF-002)
- **Defects:** 1 fixed, 1 open
- **Change Requests:** 1 approved, pending implementation

---
*Note: Demo traceability matrix with mock linkages.*