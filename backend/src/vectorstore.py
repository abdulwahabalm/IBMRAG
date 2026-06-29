import chromadb


class VectorStore:
    def __init__(self, persist_path: str = "./chroma_db"):
        self._client = chromadb.PersistentClient(path=persist_path)
        self._collection = self._client.get_or_create_collection(
            name="blood_tests",
            metadata={"hnsw:space": "cosine"},
        )

    def add(self, texts: list[str], embeddings: list[list[float]], doc_id: str) -> None:
        ids = [f"{doc_id}__{i}" for i in range(len(texts))]
        self._collection.add(
            embeddings=embeddings,
            documents=texts,
            ids=ids,
            metadatas=[{"doc_id": doc_id, "chunk_index": i} for i in range(len(texts))],
        )

    def query(self, query_embedding: list[float], n_results: int = 5) -> list[str]:
        results = self._collection.query(
            query_embeddings=[query_embedding],
            n_results=min(n_results, self._collection.count()),
        )
        return results["documents"][0]

    def count(self) -> int:
        return self._collection.count()
