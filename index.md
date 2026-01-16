---
layout: default
title: Home
---

# PlantUML Ent Kit

PlantUML-based Entity Modeling Toolkit with Reference Architecture Catalogue.

## Quick Links

- [Agent Guide (AGENTS.md)](AGENTS.md) - For AI agents adding new patterns
- [Full README](README.md) - Complete documentation

---

## AI/LLM Architecture Patterns

| Pattern | Description |
|---------|-------------|
| [LLM Tool Call](catalogue/reference-architectures/llm-tool-call.md) | Function calling pattern for LLMs |
| [LLM Context Management](catalogue/reference-architectures/llm-context-management.md) | Subagents, RAG, compaction, sliding windows |
| [Model Context Protocol (MCP)](catalogue/reference-architectures/mcp-architecture.md) | Standardized AI-tool integration |
| [Skills Pattern](catalogue/reference-architectures/skills-pattern.md) | Composable agent capabilities |
| [Agent Orchestration](catalogue/reference-architectures/agent-orchestration.md) | Multi-agent coordination |
| [Tool Chaining](catalogue/reference-architectures/tool-chaining.md) | Sequential tool execution |
| [Agentic RAG](catalogue/reference-architectures/agentic-rag.md) | Retrieval-augmented generation |

---

## Research Papers

| Paper | Description |
|-------|-------------|
| [DeepSeek Engram](catalogue/research-papers/deepseek-engram.md) | O(1) knowledge retrieval via n-gram hashing |

---

## Entity Reference Models

| Model | Domain |
|-------|--------|
| [CRM](catalogue/reference-architectures/crm.md) | Customer Relationship Management |
| [E-Commerce](catalogue/reference-architectures/ecomm.md) | Online Shopping Systems |
| [LMS](catalogue/reference-architectures/lms.md) | Learning Management |
| [CMS](catalogue/reference-architectures/cms.md) | Content Management |
| [HMS](catalogue/reference-architectures/hms.md) | Hospital Management |

---

## How It Works

1. **PlantUML source files** in `catalogue/*/uml/*.puml`
2. **GitHub Actions** validates and renders to PNG
3. **Documentation** in matching `*.md` files
4. **GitHub Pages** serves the site

See [AGENTS.md](AGENTS.md) for adding new patterns.
