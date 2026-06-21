# User Stories
**Project:** Agentic RAG Blood Test Analysis System  
**Linked to:** REQ-001  
**Status:** Draft (Demo)  
**Last Updated:** 2026-06-21

## User Story 1: Upload Blood Test Document
**US-001**  
**As a** patient  
**I want to** upload my blood test document (PDF/TXT/Image)  
**So that** I can receive AI-generated insights about my results

**Acceptance Criteria:**
- Upload button visible on main screen
- Accepts PDF, TXT, and image formats
- Shows upload progress indicator
- Displays success/error message after upload
- Synthetic data disclaimer shown before upload

## User Story 2: View Blood Marker Analysis
**US-002**  
**As a** patient  
**I want to** view analysis for 4 key markers (haemoglobin, whiteBloodCells, ferritin, crp)  
**So that** I can understand my blood test results

**Acceptance Criteria:**
- Display marker name, value, and normal range
- Show status indicator (optimal/attention/improving)
- Color-coded visual representation
- Clinician review notice displayed prominently

## User Story 3: Receive Actionable Recommendations
**US-003**  
**As a** patient  
**I want to** receive personalized recommendations based on my markers  
**So that** I can take informed actions about my health

**Acceptance Criteria:**
- At least one recommendation per marker
- Recommendations include title and detailed explanation
- Evidence-based suggestions from RAG retrieval
- Clear disclaimer that recommendations are informational only

## User Story 4: Audit Trail Visibility
**US-004**  
**As a** system administrator  
**I want to** track all blood test analysis requests  
**So that** I can ensure compliance and troubleshoot issues

**Acceptance Criteria:**
- Log timestamp, user ID, and document ID
- Record analysis results and confidence scores
- Store audit logs for minimum 90 days
- Logs accessible via admin dashboard

---
*Note: Demo user stories with mock acceptance criteria.*