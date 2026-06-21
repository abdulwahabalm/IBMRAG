# User Stories Document
## IBM BOB SDLC Demo: Agentic RAG Blood Test Analysis System

**Document Version:** 1.0  
**Date:** June 21, 2026  
**Project:** IBM BOB SDLC Demonstration  
**Use Case:** Agentic RAG Blood Test Analysis System  
**Related Document:** [Business Requirements](01-business-requirements.md)

---

## G. User Stories

This section contains comprehensive user stories for the Agentic RAG blood test analysis system, organized by persona. Each story includes acceptance criteria in Given/When/Then format, priority levels, linked requirement IDs, and story point estimates.

---

### Healthcare Staff User Stories

#### US-001: Submit Blood Test Values for Analysis

**Persona:** Healthcare Staff User (Nurse, Medical Assistant)

**User Story:**  
As a healthcare staff member, I want to enter synthetic blood test values into the frontend interface, so that I can quickly obtain structured analysis and insights for the 8 standard blood markers.

**Acceptance Criteria:**

1. **Given** I am on the blood test entry screen, **When** I view the input form, **Then** I see clearly labeled fields for all 8 blood markers (Haemoglobin, White blood cells, Platelets, Ferritin, Vitamin D, CRP, ALT, Creatinine) with reference ranges displayed
2. **Given** I have entered valid values for all 8 blood markers, **When** I click the submit button, **Then** the system validates the input and sends the data to the backend API with a loading indicator displayed
3. **Given** the backend returns analysis results, **When** the response is received, **Then** the system displays the structured analysis with marker values, abnormal flags, and explanations within 10 seconds
4. **Given** I enter an invalid value (e.g., negative number or non-numeric text), **When** I attempt to submit, **Then** the system displays a clear validation error message indicating which field is invalid
5. **Given** I have submitted blood test data, **When** the analysis is complete, **Then** I see a prominent safety disclaimer stating that results are informational only and must be reviewed by qualified clinicians

**Priority:** Critical

**Linked Requirements:** FR-001, FR-008, FR-009, NFR-001, SR-001, SR-002

**Story Points:** 5

---

#### US-002: View Structured Blood Test Analysis Results

**Persona:** Healthcare Staff User (Nurse, Medical Assistant)

**User Story:**  
As a healthcare staff member, I want to view structured blood test analysis results with clear visual indicators, so that I can quickly identify abnormal values and understand their clinical significance.

**Acceptance Criteria:**

1. **Given** the analysis is complete, **When** I view the results screen, **Then** I see a summary overview section highlighting the total number of markers analyzed and count of abnormal findings
2. **Given** I am viewing the marker list, **When** I scan through the results, **Then** each marker displays its value, reference range, and a visual indicator (color-coded badge or icon) showing normal/abnormal status
3. **Given** a marker is flagged as abnormal, **When** I view that marker's details, **Then** I see a detailed explanation of what the abnormal value may indicate and why it's outside the normal range
4. **Given** I am reviewing the analysis, **When** I scroll to the evidence section, **Then** I see the retrieved medical knowledge sources that informed the analysis with clear references
5. **Given** I need to understand the analysis basis, **When** I view the results, **Then** I see confidence indicators or uncertainty statements where applicable

**Priority:** Critical

**Linked Requirements:** FR-004, FR-005, FR-006, FR-009, ER-001, ER-002, ER-003, SR-004, SR-005

**Story Points:** 8

---

#### US-003: Upload Blood Test Data File

**Persona:** Healthcare Staff User (Nurse, Medical Assistant)

**User Story:**  
As a healthcare staff member, I want to upload a blood test data file instead of manual entry, so that I can save time when processing multiple test results or pre-formatted reports.

**Acceptance Criteria:**

1. **Given** I am on the blood test entry screen, **When** I view the interface, **Then** I see both manual entry and file upload options clearly presented
2. **Given** I select the file upload option, **When** I drag and drop a valid blood test file or click to browse, **Then** the system accepts common file formats (TXT, CSV) and displays the filename
3. **Given** I have uploaded a file, **When** the system parses the file, **Then** it extracts the blood marker values and displays them in the preview area for verification before submission
4. **Given** the uploaded file is invalid or corrupted, **When** the system attempts to parse it, **Then** I receive a user-friendly error message explaining the issue and suggesting corrective action
5. **Given** I have uploaded and verified the data, **When** I click submit, **Then** the system processes the file data identically to manual entry with the same validation and analysis flow

**Priority:** High

**Linked Requirements:** FR-001, FR-008, NFR-004, SR-001

**Story Points:** 5

---

#### US-004: Handle API Communication Errors Gracefully

**Persona:** Healthcare Staff User (Nurse, Medical Assistant)

**User Story:**  
As a healthcare staff member, I want to receive clear error messages when the system encounters problems, so that I understand what went wrong and know what action to take.

**Acceptance Criteria:**

1. **Given** I submit blood test data, **When** the backend API is unavailable or times out, **Then** I see a user-friendly error message stating "Unable to connect to analysis service. Please try again in a moment."
2. **Given** an API error occurs, **When** the error message is displayed, **Then** I see a retry button that allows me to resubmit without re-entering all data
3. **Given** the system encounters a validation error from the backend, **When** the error response is received, **Then** I see specific guidance on which values need correction
4. **Given** I am waiting for analysis results, **When** the request exceeds the expected response time, **Then** I see a progress indicator with a message like "Analysis in progress, this may take a few moments..."
5. **Given** a critical error occurs, **When** the system cannot recover, **Then** I see an error reference ID that can be used for support and troubleshooting

**Priority:** High

**Linked Requirements:** NFR-004, FR-012, BR-002

**Story Points:** 3

---

### Clinician Reviewer Stories

#### US-005: Review Analysis with Source References

**Persona:** Clinician Reviewer (Doctor, Physician)

**User Story:**  
As a clinician, I want to review the AI-generated blood test analysis along with its source references, so that I can validate the accuracy of the insights and make informed clinical decisions.

**Acceptance Criteria:**

1. **Given** I am reviewing a blood test analysis, **When** I view the results, **Then** I see each finding accompanied by references to the specific medical knowledge sources retrieved from the vector database
2. **Given** I want to verify the analysis basis, **When** I click on a source reference, **Then** I see the full retrieved context chunk that informed that particular insight
3. **Given** I am evaluating an abnormal marker, **When** I review the explanation, **Then** I can trace the reasoning back to authoritative medical sources with clear citations
4. **Given** I need to assess the reliability, **When** I view the analysis, **Then** I see indicators of confidence level or uncertainty where the system has limited information
5. **Given** I am reviewing multiple markers, **When** I examine the overall analysis, **Then** I can identify which retrieved sources contributed to each specific finding

**Priority:** Critical

**Linked Requirements:** FR-006, ER-001, ER-002, ER-004, BR-003

**Story Points:** 5

---

#### US-006: Validate AI-Generated Insights Against Clinical Knowledge

**Persona:** Clinician Reviewer (Doctor, Physician)

**User Story:**  
As a clinician, I want to understand how the RAG system arrived at its conclusions, so that I can validate the insights against my clinical knowledge and identify any potential errors or limitations.

**Acceptance Criteria:**

1. **Given** I am reviewing an analysis, **When** I examine the marker explanations, **Then** I see clear reasoning that connects the measured value, reference range, and clinical significance
2. **Given** the system flags multiple abnormal markers, **When** I review the findings, **Then** I can see if the system identified any potential relationships or patterns between the markers
3. **Given** I need to verify the analysis, **When** I compare the AI output to the retrieved sources, **Then** I can confirm that the generated insights are grounded in the retrieved medical knowledge
4. **Given** I am assessing the system's limitations, **When** I review the analysis, **Then** I see appropriate caveats about what the system cannot determine (e.g., diagnosis, treatment recommendations)
5. **Given** I want to understand the retrieval quality, **When** I examine the sources, **Then** I can assess whether the most relevant medical knowledge was retrieved for the submitted markers

**Priority:** High

**Linked Requirements:** ER-001, ER-002, ER-003, SR-003, SR-004, SR-005

**Story Points:** 5

---

#### US-007: Access Patient Context and Audit Information

**Persona:** Clinician Reviewer (Doctor, Physician)

**User Story:**  
As a clinician, I want to access the audit trail and metadata for each blood test analysis, so that I can understand when the analysis was performed and maintain proper clinical documentation.

**Acceptance Criteria:**

1. **Given** I am reviewing an analysis, **When** I view the results screen, **Then** I see the unique audit identifier, timestamp, and synthetic patient identifier clearly displayed
2. **Given** I need to document my review, **When** I access the audit information, **Then** I can copy or export the audit ID for inclusion in clinical notes
3. **Given** I am reviewing the analysis metadata, **When** I examine the details, **Then** I see which blood markers were submitted, their values, and the reference ranges used
4. **Given** I need to verify the analysis timeline, **When** I check the timestamps, **Then** I can see when the data was submitted and when the analysis was completed
5. **Given** I am conducting a clinical review, **When** I view the complete analysis record, **Then** I see all safety disclaimers and warnings that were presented to the user

**Priority:** High

**Linked Requirements:** FR-007, PR-002, ER-004, SR-002

**Story Points:** 3

---

### Compliance/Audit Reviewer Stories

#### US-008: Access Complete Audit Trail for Compliance

**Persona:** Compliance/Audit Reviewer

**User Story:**  
As a compliance reviewer, I want to access complete audit trails for all blood test analyses, so that I can verify the system meets regulatory requirements and maintains proper documentation.

**Acceptance Criteria:**

1. **Given** I am conducting an audit, **When** I access the audit trail, **Then** I see unique identifiers for each analysis request with timestamps in ISO 8601 format
2. **Given** I need to verify traceability, **When** I examine an audit record, **Then** I can trace from the input data through retrieval to the generated output with full documentation
3. **Given** I am reviewing system compliance, **When** I check the audit logs, **Then** I see records of which medical knowledge sources were retrieved and used for each analysis
4. **Given** I need to verify data handling, **When** I review the audit trail, **Then** I can confirm that only synthetic data was processed and no real patient information was stored
5. **Given** I am assessing system behavior, **When** I examine multiple audit records, **Then** I can identify patterns, error rates, and system performance metrics

**Priority:** High

**Linked Requirements:** FR-007, PR-002, ER-004, BR-003, SR-001

**Story Points:** 5

---

#### US-009: Verify Safety Disclaimers and Warnings

**Persona:** Compliance/Audit Reviewer

**User Story:**  
As a compliance reviewer, I want to verify that all safety disclaimers and warnings are properly displayed, so that I can ensure the system meets healthcare safety requirements and liability protections.

**Acceptance Criteria:**

1. **Given** I am reviewing the user interface, **When** I examine any analysis results screen, **Then** I see prominent disclaimers stating that outputs are informational only and must be reviewed by qualified clinicians
2. **Given** I am checking safety compliance, **When** I review the system outputs, **Then** I verify that no diagnosis or treatment advice is provided, only informational analysis
3. **Given** I need to assess warning visibility, **When** I view the results on different devices (desktop, mobile), **Then** I confirm that safety disclaimers remain prominent and clearly visible
4. **Given** I am reviewing the language used, **When** I examine all system outputs, **Then** I verify that cautious, non-alarmist language is used throughout
5. **Given** I am conducting a compliance audit, **When** I review the system documentation, **Then** I can confirm that safety requirements SR-001 through SR-005 are fully implemented

**Priority:** Critical

**Linked Requirements:** SR-001, SR-002, SR-003, SR-004, SR-005, BR-004

**Story Points:** 3

---

#### US-010: Review Explainability and Traceability

**Persona:** Compliance/Audit Reviewer

**User Story:**  
As a compliance reviewer, I want to verify that the system provides full explainability and traceability for all AI-generated outputs, so that I can ensure the system meets AI transparency requirements.

**Acceptance Criteria:**

1. **Given** I am auditing AI outputs, **When** I review any analysis result, **Then** I can trace each generated insight back to specific retrieved source documents
2. **Given** I need to verify explainability, **When** I examine the system outputs, **Then** I see clear documentation of which vector database queries were executed and what context was retrieved
3. **Given** I am assessing transparency, **When** I review abnormal marker flags, **Then** I can identify the specific criteria and thresholds that triggered each flag
4. **Given** I need to validate the RAG process, **When** I examine the audit trail, **Then** I see records of the retrieval step (ChromaDB query) and the generation step (Ollama LLM) separately documented
5. **Given** I am conducting an explainability audit, **When** I review the system, **Then** I can confirm that requirements ER-001 through ER-004 are fully satisfied with documented evidence

**Priority:** High

**Linked Requirements:** ER-001, ER-002, ER-003, ER-004, BR-003

**Story Points:** 5

---

### Frontend Developer Stories

#### US-011: Implement RESTful API Integration

**Persona:** Frontend Developer

**User Story:**  
As a frontend developer, I want to implement clean RESTful API integration with the backend, so that the frontend can reliably communicate with the Agentic RAG system and handle responses properly.

**Acceptance Criteria:**

1. **Given** I am implementing the API client, **When** I create the service layer, **Then** I implement proper HTTP methods (POST for analysis submission, GET for status checks) with appropriate headers
2. **Given** I need to handle API responses, **When** I receive data from the backend, **Then** I parse the JSON response structure containing markers, flags, explanations, sources, and audit metadata
3. **Given** I am implementing error handling, **When** the API returns error responses, **Then** I properly catch and handle different HTTP status codes (400, 500, 503) with appropriate user messages
4. **Given** I need to manage loading states, **When** an API request is in progress, **Then** I implement proper async/await patterns with loading indicators and timeout handling
5. **Given** I am testing the integration, **When** I verify the implementation, **Then** I can successfully submit blood test data and receive structured analysis results matching the API contract

**Priority:** Critical

**Linked Requirements:** FR-012, NFR-004, NFR-007, BR-002

**Story Points:** 5

---

#### US-012: Implement Responsive Design for Multiple Devices

**Persona:** Frontend Developer

**User Story:**  
As a frontend developer, I want to implement responsive design that works across desktop and mobile devices, so that healthcare staff can access the system from various devices in clinical settings.

**Acceptance Criteria:**

1. **Given** I am implementing the UI, **When** I design the blood test entry form, **Then** it adapts gracefully to screen sizes from 320px (mobile) to 1920px (desktop) widths
2. **Given** I need to display analysis results, **When** I implement the results view, **Then** marker cards and tables reflow appropriately on smaller screens without horizontal scrolling
3. **Given** I am implementing touch interactions, **When** I test on mobile devices, **Then** all buttons and interactive elements have appropriate touch targets (minimum 44x44px)
4. **Given** I need to ensure readability, **When** I view the interface on different devices, **Then** text remains legible with appropriate font sizes and line heights for each breakpoint
5. **Given** I am testing responsive behavior, **When** I verify the implementation, **Then** safety disclaimers remain prominent and visible across all device sizes

**Priority:** Medium

**Linked Requirements:** NFR-003, FR-008, FR-009, SR-002

**Story Points:** 5

---

#### US-013: Implement Comprehensive Error Handling UI

**Persona:** Frontend Developer

**User Story:**  
As a frontend developer, I want to implement comprehensive error handling with user-friendly messages, so that users understand what went wrong and know how to proceed when errors occur.

**Acceptance Criteria:**

1. **Given** I am implementing error handling, **When** a network error occurs, **Then** I display a user-friendly message with a retry button that preserves the user's entered data
2. **Given** I need to handle validation errors, **When** the backend returns validation failures, **Then** I highlight the specific fields with errors and display inline error messages
3. **Given** I am implementing timeout handling, **When** an API request exceeds 10 seconds, **Then** I display a progress message and provide an option to cancel or continue waiting
4. **Given** I need to handle unexpected errors, **When** a critical error occurs, **Then** I display an error reference ID and provide guidance on next steps (retry, contact support)
5. **Given** I am testing error scenarios, **When** I simulate various failure conditions, **Then** the UI remains stable and never shows raw error messages or stack traces to users

**Priority:** High

**Linked Requirements:** NFR-004, FR-012, BR-002

**Story Points:** 3

---

### Backend Developer Stories

#### US-014: Implement RAG System with Vector Store Integration

**Persona:** Backend Developer

**User Story:**  
As a backend developer, I want to implement the RAG system with ChromaDB vector store integration, so that the system can retrieve relevant medical knowledge to inform blood test analysis.

**Acceptance Criteria:**

1. **Given** I am implementing the retrieval layer, **When** I receive blood test data, **Then** I construct appropriate queries to ChromaDB based on the submitted marker names and values
2. **Given** I need to retrieve relevant context, **When** I query the vector store, **Then** I retrieve the top-k most relevant medical knowledge chunks (k=3-5) with similarity scores
3. **Given** I am implementing the generation layer, **When** I have retrieved context, **Then** I pass it to the Ollama llama3.2 model along with the blood test data using a structured prompt
4. **Given** I need to ensure quality, **When** I implement the RAG pipeline, **Then** I include relevance filtering to exclude retrieved chunks with similarity scores below a threshold
5. **Given** I am testing the implementation, **When** I submit test blood test data, **Then** the system successfully retrieves relevant sources and generates structured analysis within 10 seconds

**Priority:** Critical

**Linked Requirements:** FR-002, FR-003, FR-006, NFR-001, ER-001, ER-002

**Story Points:** 8

---

#### US-015: Implement Structured Analysis Generation

**Persona:** Backend Developer

**User Story:**  
As a backend developer, I want to implement structured analysis generation that flags abnormal values and provides detailed explanations, so that the system delivers actionable insights to users.

**Acceptance Criteria:**

1. **Given** I am implementing marker analysis, **When** I process blood test values, **Then** I compare each marker against its reference range and flag values outside normal ranges
2. **Given** I need to generate explanations, **When** I use the LLM, **Then** I structure the prompt to request specific explanations for each marker, especially abnormal ones
3. **Given** I am implementing the response format, **When** I return analysis results, **Then** I structure the JSON response with markers array, flags, explanations, sources, and audit metadata
4. **Given** I need to include safety measures, **When** I generate any output, **Then** I include prominent disclaimers and ensure no diagnosis or treatment advice is provided
5. **Given** I am testing the implementation, **When** I process various blood test scenarios, **Then** the system correctly identifies abnormal values and provides appropriate explanations grounded in retrieved sources

**Priority:** Critical

**Linked Requirements:** FR-004, FR-005, FR-006, SR-002, SR-003, SR-004, ER-003

**Story Points:** 8

---

#### US-016: Implement API Endpoints with Audit Trail

**Persona:** Backend Developer

**User Story:**  
As a backend developer, I want to implement RESTful API endpoints with comprehensive audit trail generation, so that the system maintains full traceability and supports compliance requirements.

**Acceptance Criteria:**

1. **Given** I am implementing the API, **When** I create the analysis endpoint, **Then** I implement POST /api/analyze with proper request validation and response formatting
2. **Given** I need to generate audit trails, **When** I process any analysis request, **Then** I generate a unique audit ID (UUID format) and timestamp for the transaction
3. **Given** I am implementing traceability, **When** I log audit information, **Then** I record the input data, retrieved sources, generated output, and processing time
4. **Given** I need to handle errors, **When** exceptions occur, **Then** I return appropriate HTTP status codes with structured error messages and log the error with the audit ID
5. **Given** I am testing the implementation, **When** I verify the API, **Then** I can confirm that every request generates a complete audit trail with all required metadata

**Priority:** High

**Linked Requirements:** FR-007, FR-012, PR-002, ER-004, BR-003

**Story Points:** 5

---

### Tester/Product Owner Stories

#### US-017: Validate Functional Requirements Coverage

**Persona:** Tester/Product Owner

**User Story:**  
As a tester, I want to validate that all functional requirements are properly implemented and tested, so that I can ensure the system meets the specified business requirements.

**Acceptance Criteria:**

1. **Given** I am creating test cases, **When** I review the functional requirements FR-001 through FR-012, **Then** I create at least one test case for each requirement with clear pass/fail criteria
2. **Given** I need to test blood marker processing, **When** I submit test data for all 8 markers (Haemoglobin, WBC, Platelets, Ferritin, Vitamin D, CRP, ALT, Creatinine), **Then** the system processes each marker correctly
3. **Given** I am testing abnormal value detection, **When** I submit blood test data with values outside reference ranges, **Then** the system correctly flags all abnormal markers
4. **Given** I need to verify retrieval functionality, **When** I examine analysis results, **Then** I can confirm that relevant medical knowledge was retrieved from ChromaDB for each marker
5. **Given** I am validating completeness, **When** I review test coverage, **Then** I can demonstrate that all functional requirements have been tested and verified

**Priority:** High

**Linked Requirements:** FR-001, FR-002, FR-003, FR-004, FR-005, FR-006, FR-007, FR-008, FR-009, FR-010, FR-011, FR-012, BR-001

**Story Points:** 8

---

#### US-018: Verify Safety and Compliance Requirements

**Persona:** Tester/Product Owner

**User Story:**  
As a tester, I want to verify that all safety and compliance requirements are properly implemented, so that I can ensure the system is safe for demonstration and meets healthcare standards.

**Acceptance Criteria:**

1. **Given** I am testing safety requirements, **When** I verify SR-001, **Then** I confirm that the system only processes synthetic data and rejects any attempt to use real patient information
2. **Given** I need to verify disclaimers, **When** I test SR-002, **Then** I confirm that prominent disclaimers appear on every results screen stating outputs are informational only
3. **Given** I am testing content safety, **When** I verify SR-003, **Then** I confirm that no diagnosis or treatment advice is provided in any system output
4. **Given** I need to verify language, **When** I test SR-004, **Then** I confirm that all outputs use cautious, non-alarmist language appropriate for healthcare contexts
5. **Given** I am validating audit trails, **When** I test PR-002, **Then** I confirm that every analysis generates a unique audit ID and maintains proper traceability

**Priority:** Critical

**Linked Requirements:** SR-001, SR-002, SR-003, SR-004, SR-005, PR-001, PR-002, PR-003, BR-004

**Story Points:** 5

---

#### US-019: Validate Non-Functional Requirements and Performance

**Persona:** Tester/Product Owner

**User Story:**  
As a tester, I want to validate that the system meets all non-functional requirements for performance, reliability, and usability, so that I can ensure a quality user experience.

**Acceptance Criteria:**

1. **Given** I am testing performance, **When** I submit blood test data for analysis, **Then** the system returns results within 10 seconds under normal load (NFR-001)
2. **Given** I need to test error handling, **When** I simulate API failures, **Then** the system displays user-friendly error messages and provides recovery options (NFR-004)
3. **Given** I am testing responsive design, **When** I access the system on desktop and mobile devices, **Then** the interface adapts appropriately and remains fully functional (NFR-003)
4. **Given** I need to verify reliability, **When** I conduct extended testing sessions, **Then** the system maintains stable operation without crashes or data loss (NFR-002)
5. **Given** I am validating the architecture, **When** I review the codebase, **Then** I confirm clear separation between frontend and backend components (NFR-007)

**Priority:** High

**Linked Requirements:** NFR-001, NFR-002, NFR-003, NFR-004, NFR-005, NFR-006, NFR-007

**Story Points:** 5

---

## User Story Summary

### Total Stories by Persona

| Persona | Story Count | Total Story Points |
|---------|-------------|-------------------|
| Healthcare Staff User | 4 | 21 |
| Clinician Reviewer | 3 | 13 |
| Compliance/Audit Reviewer | 3 | 13 |
| Frontend Developer | 3 | 13 |
| Backend Developer | 3 | 21 |
| Tester/Product Owner | 3 | 18 |
| **Total** | **19** | **99** |

### Priority Distribution

| Priority | Story Count |
|----------|-------------|
| Critical | 8 |
| High | 10 |
| Medium | 1 |
| Low | 0 |

### Requirements Coverage

All user stories are linked to specific requirements from the Business Requirements Document:

- **Business Requirements (BR):** BR-001, BR-002, BR-003, BR-004
- **Functional Requirements (FR):** FR-001 through FR-012 (complete coverage)
- **Non-Functional Requirements (NFR):** NFR-001 through NFR-007 (complete coverage)
- **Safety Requirements (SR):** SR-001 through SR-005 (complete coverage)
- **Privacy Requirements (PR):** PR-001, PR-002, PR-003
- **Explainability Requirements (ER):** ER-001 through ER-004 (complete coverage)

---

## Document Control

**Prepared by:** IBM BOB SDLC Demo Team  
**Reviewed by:** [Pending Review]  
**Approved by:** [Pending Approval]

**Change History:**

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 2026-06-21 | IBM BOB | Initial user stories document |

---

**Next Steps:**

1. Review and approval of user stories by stakeholders and product owner
2. Sprint planning and story prioritization for implementation
3. Creation of detailed acceptance test cases based on acceptance criteria
4. Technical design documentation for high-priority stories
5. Development sprint execution with story tracking

This document provides the foundation for agile development of the IBM BOB SDLC demonstration system, with clear user stories that trace back to business requirements and provide testable acceptance criteria for validation.