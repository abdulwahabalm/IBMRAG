from pathlib import Path

import ollama
import pdfplumber
import pytesseract
from PIL import Image

from .vectorstore import VectorStore

SUPPORTED_EXTENSIONS = {".pdf", ".txt", ".jpg", ".jpeg", ".png", ".bmp", ".tiff", ".tif"}
EMBED_MODEL = "nomic-embed-text"


class DocumentUploader:
    def __init__(self, vectorstore: VectorStore):
        self._vectorstore = vectorstore

    def upload(self, file_path: str, doc_id: str | None = None) -> int:
        path = Path(file_path)
        if path.suffix.lower() not in SUPPORTED_EXTENSIONS:
            raise ValueError(f"Unsupported file type '{path.suffix}'. Accepted: {SUPPORTED_EXTENSIONS}")

        text = self._extract_text(path)
        if not text.strip():
            raise ValueError("No text could be extracted from the document.")

        chunks = self._chunk(text)
        embeddings = [
            ollama.embeddings(model=EMBED_MODEL, prompt=chunk).embedding
            for chunk in chunks
        ]
        self._vectorstore.add(chunks, embeddings, doc_id or path.stem)
        return len(chunks)

    # ------------------------------------------------------------------
    # Private helpers
    # ------------------------------------------------------------------

    def _extract_text(self, path: Path) -> str:
        suffix = path.suffix.lower()
        if suffix == ".pdf":
            return self._from_pdf(path)
        if suffix == ".txt":
            return self._from_text(path)
        return self._from_image(path)

    @staticmethod
    def _from_pdf(path: Path) -> str:
        pages: list[str] = []
        with pdfplumber.open(path) as pdf:
            for page in pdf.pages:
                text = page.extract_text()
                if text:
                    pages.append(text)
        return "\n".join(pages)

    @staticmethod
    def _from_text(path: Path) -> str:
        return path.read_text(encoding="utf-8")

    @staticmethod
    def _from_image(path: Path) -> str:
        return pytesseract.image_to_string(Image.open(path))

    @staticmethod
    def _chunk(text: str, chunk_size: int = 500, overlap: int = 50) -> list[str]:
        words = text.split()
        step = chunk_size - overlap
        chunks = []
        for i in range(0, len(words), step):
            chunk = " ".join(words[i : i + chunk_size])
            if chunk.strip():
                chunks.append(chunk)
        return chunks