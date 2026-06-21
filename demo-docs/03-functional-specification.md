
# Functional Specification Document
## IBM BOB SDLC Demo: Agentic RAG Blood Test Analysis System

**Document Version:** 1.0  
**Date:** June 21, 2026  
**Project:** IBM BOB SDLC Demonstration  
**Use Case:** Agentic RAG Blood Test Analysis System  
**Related Documents:**
- [Business Requirements](01-business-requirements.md)
- [User Stories](02-user-stories.md)

---

## H. Functional Specification

### 1. Overview

#### 1.1 Purpose of the Specification

This functional specification document provides detailed technical requirements for implementing the Agentic RAG blood test analysis system. It serves as the authoritative reference for developers, testers, and stakeholders, translating business requirements and user stories into concrete, implementable specifications.

The document defines:
- Frontend user interface components and behaviors
- Backend API contracts and data structures
- Business logic for blood marker analysis and RAG operations
- Display rules and user experience requirements
- Error handling and security specifications
- Integration points between system components

This specification ensures that all team members have a shared understanding of system functionality and can implement features consistently while maintaining traceability to business requirements.

#### 1.2 Scope

This functional specification covers the complete Agentic RAG blood test analysis system, including:

**In Scope:**
- Frontend interface for blood test data entry and results display
- Backend REST API for analysis requests and responses
- RAG system integration with ChromaDB vector store and Ollama LLM
- Blood marker classification logic for 8 standard markers
- Analysis generation with retrieved evidence
- Audit trail and compliance features
- Error handling and validation
- Safety disclaimers and warnings

**Out of Scope:**
- Real patient data processing or EHR integration
- Production deployment infrastructure
- Multi-language support
- Advanced analytics or trend analysis
- Clinical validation studies

#### 1.3 Target Audience

This document is intended for:
- **Frontend Developers**: Implementing React-based user interface
- **Backend Developers**: Implementing Python API and RAG system
- **QA Engineers**: Creating test cases and validation procedures
- **Product Owners**: Reviewing feature completeness
- **Technical Architects**: Understanding system integration points
- **Compliance Reviewers**: Verifying safety and audit requirements

#### 1.4 Related Documents

| Document | Purpose | Link |
|----------|---------|------|
| Business Requirements | Defines business needs, requirements, and constraints | [`01-business-requirements.md`](01-business-requirements.md:1) |
| User Stories | Describes user personas and acceptance criteria | [`02-user-stories.md`](02-user-stories.md:1) |
| Technical Architecture | System architecture and component design | TBD |
| Test Plan | Test cases and validation procedures | TBD |

---

### 2. Frontend Specification

#### 2.1 User Interface Components

##### 2.1.1 Blood Test Entry Form

**Purpose:** Allow users to input blood test values for analysis.

**Component Structure:**

```
BloodTestEntryForm
├── FormHeader (title, instructions)
├── MarkerInputFields (8 fields)
│   ├── HaemoglobinInput
│   ├── WBCInput
│   ├── PlateletsInput
│   ├── FerritinInput
│   ├── VitaminDInput
│   ├── CRPInput
│   ├── ALTInput
│   └── CreatinineInput
├── ActionButtons
│   ├── SubmitButton
│   └── ClearButton
└── ValidationMessages
```

**Input Field Specifications:**

| Marker | Field Label | Unit | Input Type | Placeholder | Reference Range Display |
|--------|-------------|------|------------|-------------|------------------------|
| Haemoglobin | Haemoglobin (Hb) | g/dL | number | e.g., 14.5 | Male: 13.5-17.5, Female: 12.0-15.5 |
| WBC | White Blood Cells (WBC) | × 10⁹/L | number | e.g., 7.5 | 4.0-11.0 |
| Platelets | Platelets | × 10⁹/L | number | e.g., 250 | 150-400 |
| Ferritin | Ferritin | ng/mL | number | e.g., 100 | Male: 30-300, Female: 15-200 |
| Vitamin D | Vitamin D | ng/mL | number | e.g., 45 | 30-100 |
| CRP | C-Reactive Protein (CRP) | mg/L | number | e.g., 1.5 | <3.0 |
| ALT | Alanine Aminotransferase (ALT) | U/L | number | e.g., 25 | 7-56 |
| Creatinine | Creatinine | mg/dL | number | e.g., 1.0 | Male: 0.7-1.3, Female: 0.6-1.1 |

**Field Properties:**
- All fields are required
- Decimal precision: up to 2 decimal places
- Reference ranges displayed below or beside each field
- Real-time validation feedback
- Clear visual distinction between valid and invalid states

**Submit Button Behavior:**
- Label: "Analyze Blood Test"
- Enabled only when all fields are valid
- On click: Validates all fields, displays loading state, sends API request
- Loading state: Button disabled, shows spinner with text "Analyzing..."
- Success: Navigates to results display
- Error: Displays error message, remains on form

**Clear/Reset Functionality:**
- Label: "Clear All"
- On click: Clears all input fields, resets validation states
- Confirmation dialog: "Are you sure you want to clear all entered values?"

**Related Requirements:** FR-001, FR-008, US-001

---

##### 2.1.2 File Upload Component

**Purpose:** Allow users to upload blood test data files as an alternative to manual entry.

**Component Structure:**

```
FileUploadComponent
├── DropZone (drag-and-drop area)
├── BrowseButton
├── FilePreview
│   ├── FileName
│   ├── FileSize
│   └── RemoveButton
├── ParsedDataPreview (extracted values)
└── UploadButton
```

**Supported File Formats:**
- Plain text (.txt)
- Comma-separated values (.csv)
- Maximum file size: 5 MB

**File Format Expectations:**

Text format example:
```
Haemoglobin: 14.5 g/dL
White Blood Cells: 7.5 × 10⁹/L
Platelets: 250 × 10⁹/L
Ferritin: 100 ng/mL
Vitamin D: 45 ng/mL
CRP: 1.5 mg/L
ALT: 25 U/L
Creatinine: 1.0 mg/dL
```

CSV format example:
```
Marker,Value,Unit
Haemoglobin,14.5,g/dL
WBC,7.5,× 10⁹/L
Platelets,250,× 10⁹/L
Ferritin,100,ng/mL
Vitamin D,45,ng/mL
CRP,1.5,mg/L
ALT,25,U/L
Creatinine,1.0,mg/dL
```

**Upload Flow:**
1. User drags file or clicks browse button
2. System validates file type and size
3. System parses file content
4. Extracted values displayed in preview area
5. User reviews and confirms values
6. User clicks "Analyze" to submit

**Error Handling:**
- Invalid file type: "Please upload a .txt or .csv file"
- File too large: "File size exceeds 5 MB limit"
- Parse error: "Unable to parse file. Please check format and try again"
- Missing markers: "File is missing required markers: [list]"

**Related Requirements:** FR-008, US-003

---

##### 2.1.3 Results Display Component

**Purpose:** Display structured blood test analysis results with visual indicators and explanations.

**Component Structure:**

```
ResultsDisplayComponent
├── ResultsHeader
│   ├── AnalysisTitle
│   ├── Timestamp
│   └── AuditID
├── SafetyDisclaimer (prominent)
├── SummaryCard
│   ├── TotalMarkersAnalyzed
│   ├── AbnormalCount
│   └── OverallStatus
├── MarkerResultsList
│   └── MarkerCard (×8)
│       ├── MarkerName
│       ├── MeasuredValue
│       ├── ReferenceRange
│       ├── StatusBadge (Low/Normal/High)
│       ├── Explanation
│       └── ConfidenceIndicator
├── RetrievedEvidenceSection
│   └── EvidenceCard (×3-5)
│       ├── SourceReference
│       ├── RelevanceScore
│       └── ContextSnippet
├── FollowUpQuestions
│   └── SuggestedQuestion (×3-5)
└── ActionButtons
    ├── ExportButton
    └── NewAnalysisButton
```

**Summary Card Specifications:**
- Total markers analyzed: Count (always 8)
- Abnormal findings: Count and percentage
- Overall status: Visual indicator (green/yellow/red)
- Brief summary text: "X of 8 markers are within normal range"

**Marker Card Specifications:**

Each marker displays:
- **Marker Name:** Bold, prominent (e.g., "Haemoglobin (Hb)")
- **Measured Value:** Large font with unit (e.g., "14.5 g/dL")
- **Reference Range:** Smaller font (e.g., "Normal: 13.5-17.5 g/dL")
- **Status Badge:** Color-coded pill badge
  - Normal: Green badge with "✓ Normal"
  - Low: Yellow badge with "↓ Low"
  - High: Red badge with "↑ High"
- **Explanation:** 2-3 sentences explaining the result
- **Confidence Indicator:** Optional, shown when confidence is low

**Status Badge Color Scheme:**
- Normal: `#10B981` (green)
- Low: `#F59E0B` (amber)
- High: `#EF4444` (red)

**Marker Display Order:**
1. Abnormal markers first (sorted by severity)
2. Normal markers second (alphabetical)

**Related Requirements:** FR-004, FR-005, FR-009, US-002

---

##### 2.1.4 Retrieved Evidence Section

**Purpose:** Display source references and retrieved context that informed the analysis.

**Evidence Card Specifications:**

Each evidence card displays:
- **Source Reference:** Citation format (e.g., "Medical Reference Database - Blood Markers")
- **Relevance Score:** Percentage or visual indicator (e.g., "95% relevant")
- **Context Snippet:** 2-3 sentences of retrieved text
- **Expand Button:** Option to view full retrieved context
- **Related Markers:** Which markers this evidence informed

**Display Format:**

```
┌─────────────────────────────────────────────────┐
│ 📚 Source: Medical Reference Database          │
│ Relevance: ████████░░ 85%                      │
│                                                 │
│ "Haemoglobin levels below 12.0 g/dL in females │
│ may indicate anemia. Common causes include     │
│ iron deficiency, chronic disease, or blood     │
│ loss..."                                        │
│                                                 │
│ Related to: Haemoglobin, Ferritin             │
