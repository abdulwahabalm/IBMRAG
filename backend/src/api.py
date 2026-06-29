"""
FastAPI application for blood test analysis.

IMPORTANT: This is DEMO/MOCK implementation.
The analysis logic is synthetic and for demonstration purposes only.
Real implementation would use the RAG agent from agent.py.
"""

from datetime import datetime
from typing import List, Optional
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field


# ============================================================================
# Request/Response Models
# ============================================================================

class BloodTestRequest(BaseModel):
    """Request model for blood test analysis."""
    haemoglobin: float = Field(..., description="Haemoglobin level in g/dL")
    whiteBloodCells: float = Field(..., description="White blood cell count in × 10⁹/L")
    ferritin: float = Field(..., description="Ferritin level in ng/mL")
    crp: float = Field(..., description="C-reactive protein level in mg/L")


class MarkerAnalysis(BaseModel):
    """Analysis for a single blood test marker."""
    marker: str
    value: float
    unit: str
    referenceRange: str
    status: str  # "normal", "high", or "low"
    explanation: str
    retrievedEvidence: str  # MOCK: Would come from RAG in real implementation
    suggestedFollowUp: Optional[str] = None


class BloodTestAnalysis(BaseModel):
    """Complete blood test analysis response."""
    auditId: str
    disclaimer: str
    markers: List[MarkerAnalysis]
    summary: str
    safetyWarnings: List[str]


class HealthCheckResponse(BaseModel):
    """Health check response."""
    status: str
    timestamp: str


# ============================================================================
# FastAPI Application Setup
# ============================================================================

app = FastAPI(
    title="Blood Test Analysis API",
    description="DEMO API for blood test analysis (mock implementation)",
    version="0.1.0"
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify actual origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ============================================================================
# DEMO/MOCK Analysis Logic
# ============================================================================

def _determine_status(value: float, low: float, high: float) -> str:
    """Determine if a value is normal, low, or high."""
    if value < low:
        return "low"
    elif value > high:
        return "high"
    else:
        return "normal"


def _analyze_haemoglobin(value: float) -> MarkerAnalysis:
    """DEMO: Analyze haemoglobin level."""
    ref_low, ref_high = 12.0, 16.0
    status = _determine_status(value, ref_low, ref_high)
    
    explanations = {
        "low": f"Haemoglobin level of {value} g/dL is below the normal range. This may indicate anemia, which can cause fatigue and weakness.",
        "high": f"Haemoglobin level of {value} g/dL is above the normal range. This may indicate dehydration or polycythemia.",
        "normal": f"Haemoglobin level of {value} g/dL is within the normal range, indicating healthy oxygen-carrying capacity."
    }
    
    follow_ups = {
        "low": "Consider iron supplementation and dietary changes. Follow-up testing in 4-6 weeks recommended.",
        "high": "Ensure adequate hydration. If persistently elevated, further investigation may be needed.",
        "normal": None
    }
    
    return MarkerAnalysis(
        marker="Haemoglobin",
        value=value,
        unit="g/dL",
        referenceRange=f"{ref_low}-{ref_high}",
        status=status,
        explanation=explanations[status],
        retrievedEvidence="[MOCK] Evidence from medical literature: Normal haemoglobin ranges vary by age and sex. Low levels commonly indicate iron deficiency anemia.",
        suggestedFollowUp=follow_ups[status]
    )


def _analyze_white_blood_cells(value: float) -> MarkerAnalysis:
    """DEMO: Analyze white blood cell count."""
    ref_low, ref_high = 4.0, 11.0
    status = _determine_status(value, ref_low, ref_high)
    
    explanations = {
        "low": f"White blood cell count of {value} × 10⁹/L is below normal. This may indicate bone marrow issues or immune system suppression.",
        "high": f"White blood cell count of {value} × 10⁹/L is elevated. This may indicate infection, inflammation, or stress response.",
        "normal": f"White blood cell count of {value} × 10⁹/L is within normal range, indicating healthy immune function."
    }
    
    follow_ups = {
        "low": "Consult with a hematologist. Avoid exposure to infections. Repeat testing recommended.",
        "high": "Investigate potential infection or inflammatory conditions. Repeat testing in 1-2 weeks if symptoms persist.",
        "normal": None
    }
    
    return MarkerAnalysis(
        marker="White Blood Cells",
        value=value,
        unit="× 10⁹/L",
        referenceRange=f"{ref_low}-{ref_high}",
        status=status,
        explanation=explanations[status],
        retrievedEvidence="[MOCK] Evidence from medical literature: WBC count reflects immune system activity. Elevated counts often indicate infection or inflammation.",
        suggestedFollowUp=follow_ups[status]
    )


def _analyze_ferritin(value: float) -> MarkerAnalysis:
    """DEMO: Analyze ferritin level."""
    ref_low, ref_high = 30.0, 200.0
    status = _determine_status(value, ref_low, ref_high)
    
    explanations = {
        "low": f"Ferritin level of {value} ng/mL is low, indicating depleted iron stores. This can lead to iron deficiency anemia.",
        "high": f"Ferritin level of {value} ng/mL is elevated. This may indicate inflammation, liver disease, or iron overload.",
        "normal": f"Ferritin level of {value} ng/mL is within normal range, indicating adequate iron stores."
    }
    
    follow_ups = {
        "low": "Iron supplementation recommended. Increase dietary iron intake. Retest in 8-12 weeks.",
        "high": "Investigate underlying causes such as inflammation or hemochromatosis. Further testing may be needed.",
        "normal": None
    }
    
    return MarkerAnalysis(
        marker="Ferritin",
        value=value,
        unit="ng/mL",
        referenceRange=f"{ref_low}-{ref_high}",
        status=status,
        explanation=explanations[status],
        retrievedEvidence="[MOCK] Evidence from medical literature: Ferritin is the primary iron storage protein. Low levels indicate iron deficiency before anemia develops.",
        suggestedFollowUp=follow_ups[status]
    )


def _analyze_crp(value: float) -> MarkerAnalysis:
    """DEMO: Analyze C-reactive protein level."""
    ref_low, ref_high = 0.0, 10.0
    status = _determine_status(value, ref_low, ref_high)
    
    explanations = {
        "low": f"CRP level of {value} mg/L is within normal range, indicating minimal inflammation.",
        "high": f"CRP level of {value} mg/L is elevated, indicating inflammation or infection in the body.",
        "normal": f"CRP level of {value} mg/L is within normal range, indicating no significant inflammation."
    }
    
    follow_ups = {
        "low": None,
        "high": "Investigate source of inflammation. Consider infection, autoimmune conditions, or cardiovascular risk. Repeat testing recommended.",
        "normal": None
    }
    
    return MarkerAnalysis(
        marker="C-Reactive Protein (CRP)",
        value=value,
        unit="mg/L",
        referenceRange=f"{ref_low}-{ref_high}",
        status=status,
        explanation=explanations[status],
        retrievedEvidence="[MOCK] Evidence from medical literature: CRP is an acute-phase protein that rises in response to inflammation. Elevated levels indicate active inflammatory processes.",
        suggestedFollowUp=follow_ups[status]
    )


def _generate_summary(markers: List[MarkerAnalysis]) -> str:
    """DEMO: Generate overall summary of blood test results."""
    abnormal_markers = [m for m in markers if m.status != "normal"]
    
    if not abnormal_markers:
        return "All tested markers are within normal ranges. Continue maintaining healthy lifestyle habits."
    
    abnormal_names = ", ".join(m.marker for m in abnormal_markers)
    return (
        f"Analysis shows {len(abnormal_markers)} marker(s) outside normal range: {abnormal_names}. "
        f"Review individual marker details and follow-up recommendations. "
        f"Consultation with a healthcare provider is advised for comprehensive evaluation."
    )


def _generate_safety_warnings(markers: List[MarkerAnalysis]) -> List[str]:
    """DEMO: Generate safety warnings based on marker values."""
    warnings = []
    
    for marker in markers:
        if marker.marker == "Haemoglobin" and marker.status == "low" and marker.value < 10.0:
            warnings.append("CRITICAL: Severely low haemoglobin detected. Immediate medical attention recommended.")
        
        if marker.marker == "White Blood Cells" and marker.status == "low" and marker.value < 2.0:
            warnings.append("CRITICAL: Severely low white blood cell count. Risk of serious infection. Seek immediate medical care.")
        
        if marker.marker == "C-Reactive Protein (CRP)" and marker.status == "high" and marker.value > 50.0:
            warnings.append("WARNING: Significantly elevated CRP suggests acute inflammation or infection. Medical evaluation recommended.")
    
    if not warnings:
        warnings.append("No critical safety concerns identified. However, professional medical review is always recommended.")
    
    return warnings


# ============================================================================
# API Endpoints
# ============================================================================

@app.get("/health", response_model=HealthCheckResponse)
async def health_check():
    """Health check endpoint."""
    return HealthCheckResponse(
        status="healthy",
        timestamp=datetime.utcnow().isoformat() + "Z"
    )


@app.post("/api/blood-test/analyse", response_model=BloodTestAnalysis)
async def analyze_blood_test(request: BloodTestRequest):
    """
    Analyze blood test results and provide interpretation.
    
    IMPORTANT: This is a DEMO/MOCK implementation using synthetic analysis logic.
    In production, this would integrate with the RAG agent for evidence-based analysis.
    """
    # Generate unique audit ID with timestamp
    audit_id = f"DEMO-{datetime.utcnow().strftime('%Y%m%d-%H%M%S-%f')}"
    
    # DEMO: Analyze each marker using mock logic
    markers = [
        _analyze_haemoglobin(request.haemoglobin),
        _analyze_white_blood_cells(request.whiteBloodCells),
        _analyze_ferritin(request.ferritin),
        _analyze_crp(request.crp),
    ]
    
    # Generate summary and safety warnings
    summary = _generate_summary(markers)
    safety_warnings = _generate_safety_warnings(markers)
    
    return BloodTestAnalysis(
        auditId=audit_id,
        disclaimer="This analysis is for informational support only. Review by a qualified clinician is required. This is a DEMO implementation with synthetic analysis logic.",
        markers=markers,
        summary=summary,
        safetyWarnings=safety_warnings
    )


# ============================================================================
# Application Entry Point (for direct execution)
# ============================================================================

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)

# Made with Bob
