import ollama

from .vectorstore import VectorStore

EMBED_MODEL = "nomic-embed-text"
GEN_MODEL = "llama3.2"

SYSTEM_PROMPT = (
    "You are a medical assistant specializing in interpreting blood test results. "
    "Answer the user's question using only the blood test data provided below. "
    "Reference specific values and flag any results outside the normal range. "
    "Always remind the user that your response is informational and not a substitute "
    "for professional medical advice."
)

_MAX_HISTORY_TURNS = 4


class BloodTestAgent:
    def __init__(self, vectorstore: VectorStore):
        self._vectorstore = vectorstore
        self._history: list[tuple[str, str]] = []

    def ask(self, question: str, n_context: int = 5) -> str:
        if self._vectorstore.count() == 0:
            return "No blood test data found. Please upload a document first."

        query_embedding = ollama.embeddings(model=EMBED_MODEL, prompt=question).embedding
        chunks = self._vectorstore.query(query_embedding, n_results=n_context)
        prompt = self._build_prompt(question, chunks, self._history[-_MAX_HISTORY_TURNS:])
        answer = ollama.generate(model=GEN_MODEL, prompt=prompt).response
        self._history.append((question, answer))
        return answer

    def reset(self) -> None:
        self._history.clear()

    @staticmethod
    def _build_prompt(
        question: str,
        context_chunks: list[str],
        history: list[tuple[str, str]],
    ) -> str:
        context = "\n\n---\n\n".join(context_chunks)

        history_block = ""
        if history:
            turns = "\n".join(f"User: {q}\nAssistant: {a}" for q, a in history)
            history_block = f"\nConversation so far:\n{turns}\n"

        return (
            f"{SYSTEM_PROMPT}\n\n"
            f"Blood Test Data:\n{context}\n"
            f"{history_block}\n"
            f"User: {question}\n\n"
            f"Assistant:"
        )