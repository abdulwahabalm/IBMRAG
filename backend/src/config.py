import os
from pathlib import Path
from dotenv import load_dotenv, find_dotenv
from ibm_watsonx_ai import Credentials

# find_dotenv() walks up from cwd to locate .env; the explicit fallback
# covers the case where the root .env sits above the backend/ working dir.
_dotenv_path = find_dotenv() or Path(__file__).resolve().parents[2] / ".env"
load_dotenv(_dotenv_path)


def get_credentials() -> Credentials:
    url = os.environ.get("WATSONX_URL")
    api_key = os.environ.get("WATSONX_API_KEY")
    if not url or not api_key:
        raise EnvironmentError("WATSONX_URL and WATSONX_API_KEY must be set in .env")
    return Credentials(url=url, api_key=api_key)


def get_project_id() -> str:
    project_id = os.environ.get("WATSONX_PROJECT_ID")
    if not project_id:
        raise EnvironmentError("WATSONX_PROJECT_ID must be set in .env")
    return project_id
