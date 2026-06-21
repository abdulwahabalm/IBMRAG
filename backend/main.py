import argparse
import sys
from pathlib import Path

from src.vectorstore import VectorStore
from src.uploader import DocumentUploader
from src.agent import BloodTestAgent

SAMPLES_DIR = Path(__file__).parent / "samples"


def cmd_upload(args, vectorstore):
    uploader = DocumentUploader(vectorstore)
    count = uploader.upload(args.file, doc_id=args.id)
    print(f"Uploaded '{args.file}' → {count} chunks stored.")


def cmd_seed(args, vectorstore):
    if not SAMPLES_DIR.exists():
        print(f"Samples directory not found: {SAMPLES_DIR}", file=sys.stderr)
        sys.exit(1)
    uploader = DocumentUploader(vectorstore)
    files = sorted(SAMPLES_DIR.glob("*.txt"))
    if not files:
        print("No .txt files found in samples/", file=sys.stderr)
        sys.exit(1)
    for path in files:
        try:
            count = uploader.upload(str(path), doc_id=path.stem)
            print(f"  {path.name} → {count} chunks")
        except Exception as exc:
            print(f"  {path.name} — FAILED: {exc}", file=sys.stderr)
    print(f"\nSeeded {len(files)} sample file(s).")


def cmd_ask(args, vectorstore):
    agent = BloodTestAgent(vectorstore)
    answer = agent.ask(args.question)
    print(answer)


def cmd_chat(args, vectorstore):
    agent = BloodTestAgent(vectorstore)
    print("Blood Test Assistant  |  type 'exit' to quit\n")
    try:
        while True:
            try:
                question = input("You: ").strip()
            except (EOFError, KeyboardInterrupt):
                print()
                break
            if question.lower() in ("exit", "quit"):
                break
            if not question:
                continue
            answer = agent.ask(question)
            print(f"\nAssistant: {answer}\n")
    finally:
        agent.reset()


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="ibmrag",
        description="Blood test RAG system powered by Ollama",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    up = sub.add_parser("upload", help="Ingest a blood test document (PDF, TXT, or image)")
    up.add_argument("file", help="Path to file")
    up.add_argument("--id", dest="id", default=None, help="Optional document identifier")

    sub.add_parser("seed", help="Bulk-upload all sample blood test files from samples/")

    ask = sub.add_parser("ask", help="Ask a single question about the blood test results")
    ask.add_argument("question", help="Question to ask")

    sub.add_parser("chat", help="Start an interactive multi-turn chat session")

    return parser


def main():
    parser = build_parser()
    args = parser.parse_args()

    vectorstore = VectorStore()

    dispatch = {
        "upload": cmd_upload,
        "seed": cmd_seed,
        "ask": cmd_ask,
        "chat": cmd_chat,
    }
    dispatch[args.command](args, vectorstore)


if __name__ == "__main__":
    main()