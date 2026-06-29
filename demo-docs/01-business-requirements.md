# Business Requirements Document
## IBM BOB SDLC Demo: Agentic RAG Blood Test Analysis System

**Document Version:** 1.0
**Date:** June 21, 2026
**Project:** IBM BOB SDLC Demonstration
**Use Case:** Agentic RAG Blood Test Analysis System

---

## A. Demo Objective

This demonstration showcases IBM BOB's comprehensive Software Development Lifecycle (SDLC) capabilities through a practical healthcare use case: an Agentic RAG (Retrieval-Augmented Generation) system for blood test analysis. The demo illustrates how IBM BOB supports the complete development journey—from initial business requirements capture and analysis, through design and implementation, to testing and deployment—using a real-world scenario that connects a Python-based backend RAG system with a Flutter mobile frontend.

The blood test analysis system demonstrates IBM BOB's ability to manage complex AI-driven applications where explainability, traceability, and safety are paramount. By walking through the development of a system that retrieves relevant medical knowledge and generates structured blood test insights, the demo highlights how IBM BOB facilitates requirements management, change control, documentation generation, and cross-functional collaboration across the entire SDLC. This use case is particularly compelling because it combines modern AI capabilities (vector search, LLM-based analysis) with stringent healthcare requirements (safety disclaimers, audit trails, explainable outputs).

The demonstration is designed to be presented by a single person and uses only synthetic blood test data to ensure safety and compliance. It provides a clear narrative showing how IBM BOB transforms business needs into working software while maintaining full traceability from requirements through implementation.

---

## B. Business Problem

Healthcare organizations face significant challenges in making blood test results accessible and actionable for both clinical staff and patients. Blood test reports contain complex medical terminology, reference ranges, and numerical values that can be difficult to interpret without specialized training. Clinical staff need fast, structured summaries that highlight abnormal values and provide context, while patients require clear explanations that help them understand their health status without causing unnecessary alarm.

Current manual interpretation processes are time-consuming and prone to inconsistency. When AI systems are introduced to assist with interpretation, new challenges emerge: outputs must be explainable and traceable to source data, ensuring that recommendations can be validated by qualified clinicians. The integration between frontend interfaces and backend AI systems requires clear requirements and robust API contracts to ensure reliable operation.

Safety, auditability, and change control are essential in healthcare applications. Any system that processes medical data must include appropriate disclaimers, maintain audit trails for compliance, and follow rigorous development practices. The system must clearly communicate that it provides informational support only and that all outputs must be reviewed by qualified healthcare professionals. Additionally, as medical knowledge evolves and system requirements change, the development process must support controlled updates while maintaining full documentation and traceability across all SDLC phases.

---

## C. Proposed Solution

The proposed solution is a full-stack Agentic RAG system that combines a React-based frontend interface with a Python backend API to provide structured blood test analysis. The system architecture consists of several integrated layers working together to deliver safe, explainable, and traceable blood test insights.

The **frontend interface** provides an intuitive user experience where users can upload synthetic blood test data and receive structured analysis results. Built with React, the interface displays blood test insights including marker values, abnormal flags, confidence indicators, and safety warnings. The frontend communicates with the backend through a well-defined REST API, ensuring clear separation of concerns and maintainable code.

The **backend Agentic RAG API** serves as the core intelligence layer, built on Python with Ollama (llama3.2 model) for language generation and ChromaDB as the vector store. The system implements a two-stage process: first, a **retrieval layer** queries the vector database to find relevant medical knowledge from an approved knowledge base, ensuring that all analysis is grounded in authoritative sources. Second, an **agentic analysis layer** processes the retrieved context along with the blood test data to generate structured insights.

The system returns **structured results** that include multiple components essential for safe healthcare applications: abnormal value flags that highlight markers outside normal ranges, detailed explanations that provide context for each finding, references to the retrieved source material for traceability, prominent safety warnings reminding users that outputs are informational only, and unique audit IDs for compliance tracking. Each response is designed to be both informative and appropriately cautious.

Throughout the development process, IBM BOB provides **documentation and traceability** across all SDLC phases. Requirements are captured and analyzed, design decisions are documented, implementation is tracked against specifications, and testing validates that safety and functional requirements are met. This comprehensive approach ensures that the system can be maintained, audited, and enhanced over time while maintaining full visibility into how business needs translate into working software.

---

## D. Existing Requirement

**REQ-EXIST-001: Backend Agentic RAG Analysis Capability**

The backend Agentic RAG system must accept synthetic blood test data as input and return structured analysis results with retrieved supporting context. The system shall:

- Accept blood test data containing standard markers (Haemoglobin, White blood cells, Platelets, Ferritin, Vitamin D, CRP, ALT, Creatinine) with their measured values and reference ranges
- Query the ChromaDB vector store to retrieve relevant medical knowledge related to the submitted blood test markers
- Generate structured analysis using the Ollama llama3.2 model that incorporates retrieved context
- Return results in a structured format including marker analysis, abnormal flags, explanations, and source references
- Include appropriate safety disclaimers in all responses indicating that outputs are informational and must be reviewed by qualified clinicians
- Maintain conversation history to support follow-up questions while preserving context
- Generate unique identifiers for audit trail purposes

The system currently implements this capability through the [`BloodTestAgent`](backend/src/agent.py) class with vector store integration and prompt engineering that emphasizes safety and medical accuracy.

---

## E. New Requirement

**REQ-NEW-001: Frontend Interface for Blood Test Analysis**

The system must provide a frontend interface that connects to the backend Agentic RAG API and displays blood test insights in a user-friendly, safe, and compliant manner. The frontend shall:

- Provide an intuitive interface for uploading synthetic blood test data files or entering blood test values manually
- Establish secure communication with the backend RAG API using RESTful endpoints
- Display structured blood test analysis results including:
  - Summary overview of the blood test findings
  - Individual marker values with visual indicators for normal/abnormal status
  - Detailed explanations for each marker and any abnormal findings
  - Retrieved evidence and source references that support the analysis
  - Prominent safety warnings and disclaimers
  - Audit metadata including unique identifiers and timestamps
- Implement appropriate error handling for API communication failures
- Provide visual feedback during analysis processing (loading states, progress indicators)
- Support responsive design for access across different device types
- Include clear disclaimers that the system provides informational support only and all results must be reviewed by qualified healthcare professionals
- Maintain user-friendly language while preserving medical accuracy
- Support accessibility standards for healthcare applications

This new requirement extends the existing backend capability by providing the user-facing layer necessary for practical deployment and demonstration of the complete SDLC process.

---

## F. Requirement Analysis

### Business Requirements

| ID | Requirement | Priority | Rationale |
|----|-------------|----------|-----------|
| **BR-001** | The system shall demonstrate IBM BOB's SDLC capabilities through a complete healthcare AI application | High | Core demo objective showing end-to-end development process |
| **BR-002** | The system shall provide structured blood test analysis that reduces interpretation time for clinical staff | High | Addresses primary business value proposition |
| **BR-003** | The system shall maintain full traceability from business requirements through implementation | High | Essential for demonstrating IBM BOB's documentation capabilities |
| **BR-004** | The system shall support single-person demonstration with synthetic data only | High | Practical constraint for demo execution and safety compliance |
| **BR-005** | The system shall enable controlled updates and change management throughout the SDLC | Medium | Demonstrates IBM BOB's change control capabilities |

### Functional Requirements

| ID | Requirement | Priority | Related BR |
|----|-------------|----------|------------|
| **FR-001** | The system shall accept blood test data containing standard markers (Haemoglobin, WBC, Platelets, Ferritin, Vitamin D, CRP, ALT, Creatinine) | High | BR-002 |
| **FR-002** | The system shall query ChromaDB vector store to retrieve relevant medical knowledge for submitted blood test markers | High | BR-002 |
| **FR-003** | The system shall generate structured analysis using Ollama llama3.2 model incorporating retrieved context | High | BR-002 |
| **FR-004** | The system shall flag blood test markers that fall outside normal reference ranges | High | BR-002 |
| **FR-005** | The system shall provide detailed explanations for each blood marker and any abnormal findings | High | BR-002 |
| **FR-006** | The system shall return source references for all retrieved medical knowledge used in analysis | High | BR-003 |
| **FR-007** | The system shall generate unique audit identifiers for each analysis request | High | BR-003 |
| **FR-008** | The frontend shall provide an interface for uploading blood test data files or manual entry | High | BR-002 |
| **FR-009** | The frontend shall display analysis results with visual indicators for marker status (normal/abnormal) | High | BR-002 |
| **FR-010** | The system shall support follow-up questions while maintaining conversation context | Medium | BR-002 |
| **FR-011** | The frontend shall provide loading states and progress indicators during analysis | Medium | BR-002 |
| **FR-012** | The system shall implement RESTful API endpoints for frontend-backend communication | High | BR-002 |

### Non-Functional Requirements

| ID | Requirement | Priority | Category |
|----|-------------|----------|----------|
| **NFR-001** | The system shall respond to blood test analysis requests within 10 seconds under normal load | Medium | Performance |
| **NFR-002** | The system shall maintain 99% uptime during demonstration periods | High | Reliability |
| **NFR-003** | The frontend shall be responsive and accessible across desktop and mobile devices | Medium | Usability |
| **NFR-004** | The system shall handle API communication failures gracefully with user-friendly error messages | High | Reliability |
| **NFR-005** | The system shall maintain conversation history for up to 4 previous turns | Medium | Performance |
| **NFR-006** | The system shall support concurrent analysis requests from multiple users | Low | Scalability |
| **NFR-007** | The codebase shall maintain clear separation between frontend and backend components | High | Maintainability |

### Safety Requirements

| ID | Requirement | Priority | Rationale |
|----|-------------|----------|-----------|
| **SR-001** | The system shall use only synthetic/dummy blood test data with no real patient information | Critical | Patient privacy and demo safety |
| **SR-002** | The system shall include prominent disclaimers that outputs are informational only and must be reviewed by qualified clinicians | Critical | Medical liability and user safety |
| **SR-003** | The system shall not provide diagnosis or treatment advice | Critical | Regulatory compliance and safety |
| **SR-004** | The system shall use cautious, non-alarmist language in all outputs | High | User safety and appropriate communication |
| **SR-005** | The system shall clearly indicate confidence levels or uncertainty in analysis results | High | Transparent AI communication |

### Privacy and Data Requirements

| ID | Requirement | Priority | Rationale |
|----|-------------|----------|-----------|
| **PR-001** | The system shall process only synthetic blood test data with fictional patient identifiers | Critical | Privacy compliance |
| **PR-002** | The system shall generate audit trails with unique identifiers for compliance tracking | High | Regulatory requirements |
| **PR-003** | The system shall not persist sensitive data beyond the active session | High | Data minimization principle |
| **PR-004** | The system shall implement appropriate access controls for API endpoints | Medium | Security best practices |

### Explainability Requirements

| ID | Requirement | Priority | Rationale |
|----|-------------|----------|-----------|
| **ER-001** | The system shall provide source references for all retrieved medical knowledge used in analysis | Critical | AI transparency and validation |
| **ER-002** | The system shall display the retrieved context chunks that informed each analysis | High | Explainable AI requirements |
| **ER-003** | The system shall indicate which blood markers triggered abnormal flags and why | High | Clinical decision support transparency |
| **ER-004** | The system shall maintain full traceability from user input through retrieval to generated output | High | Audit and validation requirements |

### Assumptions

1. **Demo Environment**: The demonstration will be conducted in a controlled environment with pre-configured Ollama models and ChromaDB vector store containing approved medical knowledge
2. **Synthetic Data Availability**: Sufficient synthetic blood test samples exist in the [`backend/samples/`](backend/samples/) directory to demonstrate various scenarios (normal results, abnormal findings, multiple marker types)
3. **Technical Infrastructure**: The presenter has access to a development environment with Python 3.x, Flutter/Dart SDK, and necessary dependencies installed
4. **Single User Context**: The demo focuses on single-user interaction patterns rather than multi-user concurrent access scenarios
5. **Medical Knowledge Base**: The vector store contains curated, approved medical reference material suitable for blood test interpretation

### Out of Scope

1. **Real Patient Data**: Integration with actual electronic health record (EHR) systems or processing of real patient blood test results
2. **Clinical Validation**: Formal clinical validation studies or regulatory approval processes (FDA, CE marking, etc.)
3. **Multi-language Support**: Internationalization or localization for languages other than English
4. **Advanced Analytics**: Trend analysis across multiple blood tests over time, predictive modeling, or longitudinal health tracking
5. **Production Deployment**: Production-grade infrastructure, high availability architecture, disaster recovery, or enterprise security hardening

---

## Document Control

**Prepared by:** IBM BOB SDLC Demo Team
**Reviewed by:** [Pending Review]
**Approved by:** [Pending Approval]

**Change History:**

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 2026-06-21 | IBM BOB | Initial business requirements document |

---

**Next Steps:**

1. Review and approval of business requirements by stakeholders
2. Creation of functional specifications document detailing API contracts and data models
3. Development of technical design document including architecture diagrams
4. Implementation planning and sprint breakdown
5. Test plan development aligned with requirements

This document serves as the foundation for the IBM BOB SDLC demonstration, establishing clear requirements that will be traced through design, implementation, testing, and deployment phases.

