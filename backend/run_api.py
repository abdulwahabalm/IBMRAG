#!/usr/bin/env python3
"""
Simple script to run the FastAPI development server.

Usage:
    python run_api.py

The server will start on http://0.0.0.0:8000 with auto-reload enabled.
"""

import uvicorn

if __name__ == "__main__":
    uvicorn.run(
        "src.api:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )

# Made with Bob
