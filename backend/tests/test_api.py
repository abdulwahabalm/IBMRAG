"""
Minimal tests for blood test analysis API.

Test Coverage:
- TC-001: Valid input processing
- TC-002: Invalid input rejection
- TC-006: Error handling
"""

import pytest
from fastapi.testclient import TestClient
from src.api import app


@pytest.fixture
def client():
    """Create test client for FastAPI app."""
    return TestClient(app)


def test_health_endpoint(client):
    """
    Test health check endpoint returns 200 OK.
    
    Verifies:
    - Endpoint is accessible
    - Returns correct status code
    - Response contains expected fields
    """
    response = client.get("/health")
    
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert "timestamp" in data


def test_valid_blood_test_analysis(client):
    """
    Test POST /api/blood-test/analyse with valid input.
    
    Coverage: TC-001 (Valid input processing)
    
    Verifies:
    - Valid blood test data is processed successfully
    - Response structure matches API specification
    - All required fields are present
    - Marker status is calculated correctly
    - Disclaimer is included
    """
    # Valid blood test data with normal values
    valid_request = {
        "haemoglobin": 14.0,
        "whiteBloodCells": 7.5,
        "ferritin": 100.0,
        "crp": 5.0
    }
    
    response = client.post("/api/blood-test/analyse", json=valid_request)
    
    # Verify successful response
    assert response.status_code == 200
    data = response.json()
    
    # Verify response structure
    assert "auditId" in data
    assert "disclaimer" in data
    assert "markers" in data
    assert "summary" in data
    assert "safetyWarnings" in data
    
    # Verify disclaimer is present
    assert len(data["disclaimer"]) > 0
    assert "DEMO" in data["disclaimer"]
    
    # Verify markers structure and count
    assert len(data["markers"]) == 4
    marker_names = {m["marker"] for m in data["markers"]}
    assert "Haemoglobin" in marker_names
    assert "White Blood Cells" in marker_names
    assert "Ferritin" in marker_names
    assert "C-Reactive Protein (CRP)" in marker_names
    
    # Verify each marker has required fields
    for marker in data["markers"]:
        assert "marker" in marker
        assert "value" in marker
        assert "unit" in marker
        assert "referenceRange" in marker
        assert "status" in marker
        assert "explanation" in marker
        assert "retrievedEvidence" in marker
        assert marker["status"] in ["normal", "low", "high"]
    
    # Verify marker status calculation (all values are normal)
    for marker in data["markers"]:
        assert marker["status"] == "normal"
    
    # Verify summary is present
    assert len(data["summary"]) > 0
    
    # Verify safety warnings are present
    assert len(data["safetyWarnings"]) > 0


def test_invalid_blood_test_input(client):
    """
    Test POST /api/blood-test/analyse with invalid input.
    
    Coverage: TC-002 (Invalid input rejection), TC-006 (Error handling)
    
    Verifies:
    - Missing required fields are rejected
    - Invalid data types are rejected
    - Returns 422 Unprocessable Entity
    """
    # Test with missing required field
    invalid_request_missing = {
        "haemoglobin": 14.0,
        "whiteBloodCells": 7.5,
        "ferritin": 100.0
        # Missing 'crp' field
    }
    
    response = client.post("/api/blood-test/analyse", json=invalid_request_missing)
    assert response.status_code == 422
    
    # Test with invalid data type
    invalid_request_type = {
        "haemoglobin": "not_a_number",
        "whiteBloodCells": 7.5,
        "ferritin": 100.0,
        "crp": 5.0
    }
    
    response = client.post("/api/blood-test/analyse", json=invalid_request_type)
    assert response.status_code == 422
    
    # Test with empty request body
    response = client.post("/api/blood-test/analyse", json={})
    assert response.status_code == 422

# Made with Bob
