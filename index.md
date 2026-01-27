---
layout: default
title: Home
---

# PlantUML Ent Kit

A PlantUML-based Entity Modeling Toolkit with Reference Architecture Catalogue for enterprise systems and AI/LLM patterns.

---

## Quick Links

| Resource | Description |
|----------|-------------|
| [Agent Guide](AGENTS.md) | Instructions for AI agents adding new patterns |
| [Full Documentation](README.md) | Complete setup and usage guide |
| [Git Workflows](docs/git-flows.md) | Branching strategies for teams |

---

## AI/LLM Architecture Patterns

Reference architectures for building AI-powered applications and agent systems.

### Core Patterns

| Pattern | Type | Description |
|---------|------|-------------|
| [LLM Tool Call](catalogue/reference-architectures/llm-tool-call.md) | Sequence | Function calling pattern enabling LLMs to invoke external tools, APIs, and data sources during conversations |
| [LLM Context Management](catalogue/reference-architectures/llm-context-management.md) | Component | Strategies for managing LLM context windows: subagents, RAG integration, compaction, and sliding windows |
| [Model Context Protocol (MCP)](catalogue/reference-architectures/mcp-architecture.md) | Component | Anthropic's standardized protocol for AI-tool integration with hosts, clients, and servers |

### Agent Patterns

| Pattern | Type | Description |
|---------|------|-------------|
| [Agent Orchestration](catalogue/reference-architectures/agent-orchestration.md) | Sequence | Multi-agent coordination with supervisor patterns for complex task decomposition |
| [Skills Pattern](catalogue/reference-architectures/skills-pattern.md) | Component | Composable agent capabilities as modular, reusable skill units |
| [Tool Chaining](catalogue/reference-architectures/tool-chaining.md) | Component | Sequential tool execution with data flow between steps |
| [Agentic RAG](catalogue/reference-architectures/agentic-rag.md) | Component | Retrieval-augmented generation with agent-driven query refinement |

---

## Research Papers

Diagrams explaining key concepts from AI/ML research publications.

| Paper | Topic | Description |
|-------|-------|-------------|
| [DeepSeek Engram](catalogue/research-papers/deepseek-engram.md) | Memory | O(1) knowledge retrieval via hashed n-gram embeddings for conditional memory lookup |

---

## Entity Reference Models

Domain-specific entity-relationship models for common enterprise systems.

### Business Systems

| Model | Domain | Key Entities |
|-------|--------|--------------|
| [CRM](catalogue/reference-architectures/crm.md) | Customer Relationship Management | Customers, Contacts, Opportunities, Campaigns |
| [E-Commerce](catalogue/reference-architectures/ecomm.md) | Online Shopping | Products, Orders, Payments, Inventory |

### Content & Learning

| Model | Domain | Key Entities |
|-------|--------|--------------|
| [LMS](catalogue/reference-architectures/lms.md) | Learning Management | Courses, Students, Assignments, Grades |
| [CMS](catalogue/reference-architectures/cms.md) | Content Management | Pages, Articles, Media, Authors |

### Healthcare

| Model | Domain | Key Entities |
|-------|--------|--------------|
| [HMS](catalogue/reference-architectures/hms.md) | Hospital Management | Patients, Doctors, Appointments, Records |

---

## Documentation

Guides and references for working with this toolkit.

| Document | Description |
|----------|-------------|
| [Git Workflows](docs/git-flows.md) | Three branching strategies: Agentic, Team, and Simplified GitFlow |

---

## How It Works

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  PlantUML       │────>│  GitHub         │────>│  Rendered       │
│  Source Files   │     │  Actions        │     │  PNG Images     │
│  (.puml)        │     │  (Validate +    │     │  (Auto-commit)  │
│                 │     │   Render)       │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
                                │
                                v
                        ┌─────────────────┐
                        │  GitHub Pages   │
                        │  (This Site)    │
                        └─────────────────┘
```

### Workflow Steps

1. **Source Files** — PlantUML diagrams in `catalogue/*/uml/*.puml`
2. **Validation** — GitHub Actions validates syntax before rendering
3. **Rendering** — PlantUML converts to PNG images automatically
4. **Auto-commit** — Rendered images committed to repository
5. **Documentation** — Markdown files in matching `*.md` locations
6. **Publishing** — GitHub Pages serves this documentation site

---

## Adding New Patterns

This repository supports **agentic development** — AI agents can add new patterns autonomously.

See [AGENTS.md](AGENTS.md) for:
- Directory structure and naming conventions
- PlantUML templates (Entity, Component, Sequence, Use Case)
- Documentation templates
- Validation rules and common issues

---

**Repository:** [keugenek/plantuml-ent-kit](https://github.com/keugenek/plantuml-ent-kit)
