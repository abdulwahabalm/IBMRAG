# Defects & Change Requests
**Project:** Agentic RAG Blood Test Analysis System  
**Linked to:** REQ-001  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## Sample Defects

| Defect ID | Severity | Status | Description | Found In | Root Cause |
|---|---|---|---|---|---|
| **DEF-001** | High | Fixed | Disclaimer text not visible on small mobile screens (iPhone SE) | TC-003 | CSS overflow issue in Flutter widget, text truncated below fold |
| **DEF-002** | Medium | Open | CRP marker status incorrectly shows "optimal" for value 3.5 mg/L (should be "attention") | TC-001 | Business rule logic error: condition uses `<=3` instead of `<3` |

### DEF-001 Details
- **Impact:** Safety compliance violation - users may not see synthetic data warning
- **Fix:** Adjusted `AnalysisSummaryCard` widget to use `SingleChildScrollView` with minimum height constraint
- **Verification:** Re-tested on iPhone SE, 8, and 13 Pro simulators

### DEF-002 Details
- **Impact:** Incorrect health status displayed to users, potential confusion
- **Proposed Fix:** Update `backend/src/agent.py` business rules for CRP threshold
- **Estimated Effort:** 2 hours (code change + regression testing)

## Change Request

### CR-001: Add Confidence Score and Source Reference Per Marker

**Priority:** High  
**Requested By:** Product Owner  
**Linked to:** REQ-001, US-002, US-003

**Description:**  
Enhance each blood marker analysis to include:
1. **Confidence Score:** Percentage (0-100%) indicating AI certainty in the analysis
2. **Source Reference:** Citation to specific document section or medical guideline used by RAG retrieval

**Rationale:**
- Increases transparency and trust in AI-generated insights
- Enables users to verify recommendations against source material
- Aligns with responsible AI principles

**Impact Analysis:**

| Component | Change Required | Effort |
|---|---|---|
| Backend API | Add `confidence_score` and `source_reference` fields to marker schema | 4 hours |
| RAG Agent | Modify prompt to request confidence and extract source chunks | 6 hours |
| Flutter UI | Update `MarkerList` widget to display new fields | 3 hours |
| Test Cases | Add TC-007 for confidence score validation | 2 hours |
| Documentation | Update functional spec and API docs | 1 hour |

**Total Estimated Effort:** 16 hours  
**Risk:** Low - additive change, no breaking changes to existing functionality

---
*Note: Demo defects and change request with mock data.*