---
layout: default
title: PlantUML Ent Kit - Entity Modeling & Agentic CI/CD
description: PlantUML-based Entity Modeling Toolkit with Reference Architecture Catalogue and Agentic CI/CD workflows
---

# PlantUML Ent Kit

> **Entity Modeling + AI Patterns + Agentic CI/CD**

A comprehensive toolkit for enterprise architecture diagrams, AI/LLM patterns, and fully automated development workflows.

---

## 🚀 What's New: Agentic Git Flows

This repository demonstrates **Elite-tier DORA metrics** through agentic CI/CD:

| Metric | Traditional | Agentic | Improvement |
|--------|------------|---------|-------------|
| Deploy Frequency | Weekly | Hourly | **168x** |
| Lead Time | Days | Minutes | **1440x** |
| MTTR | Hours | Instant | **∞** |

### Three Git Flow Tiers

| Flow | Automation | Use Case |
|------|------------|----------|
| [Simplified GitFlow](docs/simplified-gitflow.md) | 20% | Small teams, learning |
| [Agentic Team Flow](docs/agentic-team-flow.md) | 70% | Human oversight |
| [Full Agentic Flow](docs/agentic-git-flows.md) | 95% | Mature codebases |

📖 **Full Guide:** [Git Flows Documentation](docs/git-flows.md)

---

## 🤖 For AI Agents

This repository is **agent-optimized**:

- **[AGENTS.md](AGENTS.md)** — Complete instructions for adding patterns
- **Auto-rendering** — Push `.puml`, get PNG automatically
- **Auto-review** — AI reviews every PR
- **Self-healing** — Failed deploys auto-rollback

### Skills Available

```yaml
plantuml-render:   # .github/workflows/plantuml.yml
  trigger: push .puml files
  action: validate, render PNG, auto-commit

agentic-review:    # .github/workflows/agentic-review.yml
  trigger: PR opened
  action: analyze diff, post review, auto-merge eligible

agentic-deploy:    # .github/workflows/agentic-deploy.yml
  trigger: push to main
  action: deploy, self-heal on failure
```

---

## 📚 Pattern Catalogue

### AI/LLM Patterns

| Pattern | Description |
|---------|-------------|
| [LLM Tool Call](catalogue/reference-architectures/llm-tool-call.md) | Function calling for external APIs |
| [Context Management](catalogue/reference-architectures/llm-context-management.md) | RAG, compaction, sliding windows |
| [MCP Architecture](catalogue/reference-architectures/mcp-architecture.md) | Model Context Protocol |
| [Agent Orchestration](catalogue/reference-architectures/agent-orchestration.md) | Multi-agent coordination |
| [Skills Pattern](catalogue/reference-architectures/skills-pattern.md) | Modular agent capabilities |
| [Tool Chaining](catalogue/reference-architectures/tool-chaining.md) | Sequential tool execution |
| [Agentic RAG](catalogue/reference-architectures/agentic-rag.md) | Agent-driven retrieval |

### Git Flow Diagrams

| Diagram | Source |
|---------|--------|
| [Flow Comparison](catalogue/images/flow-comparison.png) | [.puml](catalogue/flow-comparison.puml) |
| [Flow Evolution](catalogue/images/flow-evolution.png) | [.puml](catalogue/flow-evolution.puml) |
| [DORA Comparison](catalogue/images/dora-comparison.png) | [.puml](catalogue/dora-comparison.puml) |
| [Paradigm Shifts](catalogue/images/paradigm-shifts.png) | [.puml](catalogue/paradigm-shifts.puml) |

### Entity Models

| Model | Domain |
|-------|--------|
| [CRM](catalogue/reference-architectures/crm.md) | Customer Relationship |
| [E-Commerce](catalogue/reference-architectures/ecomm.md) | Online Shopping |
| [LMS](catalogue/reference-architectures/lms.md) | Learning Management |
| [CMS](catalogue/reference-architectures/cms.md) | Content Management |

### Research Papers

| Paper | Topic |
|-------|-------|
| [DeepSeek Engram](catalogue/research-papers/deepseek-engram.md) | O(1) memory retrieval |

---

## 🔧 Quick Start

### View Diagrams

Browse the [Catalogue](catalogue/) or check [rendered images](catalogue/images/).

### Add a Pattern

1. Create `.puml` file in `catalogue/`
2. Push to any branch
3. GitHub Actions renders PNG automatically
4. Add matching `.md` documentation

### Use Agentic Workflows

Copy our workflow files to your repo:
- [agentic-review.yml](.github/workflows/agentic-review.yml)
- [agentic-deploy.yml](.github/workflows/agentic-deploy.yml)
- [plantuml.yml](.github/workflows/plantuml.yml)

---

## 📊 Workflow Architecture

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Developer   │───>│  Push Code   │───>│  AI Review   │
│  or Agent    │    │  or .puml    │    │  (30 sec)    │
└──────────────┘    └──────────────┘    └──────────────┘
                                               │
                    ┌──────────────────────────┼──────────────────────────┐
                    │                          │                          │
                    v                          v                          v
             ┌──────────────┐          ┌──────────────┐          ┌──────────────┐
             │  Render PNG  │          │  Auto-Merge  │          │  Deploy      │
             │  (PlantUML)  │          │  (if clean)  │          │  (Pages)     │
             └──────────────┘          └──────────────┘          └──────────────┘
                    │                                                    │
                    v                                                    v
             ┌──────────────┐                                    ┌──────────────┐
             │  Auto-Commit │                                    │  Self-Heal   │
             │  Images      │                                    │  on Failure  │
             └──────────────┘                                    └──────────────┘
```

---

## 🔗 Links

| Resource | URL |
|----------|-----|
| **Repository** | [github.com/keugenek/plantuml-ent-kit](https://github.com/keugenek/plantuml-ent-kit) |
| **Live Site** | [keugenek.github.io/plantuml-ent-kit](https://keugenek.github.io/plantuml-ent-kit/) |
| **PlantUML** | [plantuml.com](https://plantuml.com/) |
| **DORA Metrics** | [dora.dev](https://dora.dev/) |

---

**Built with PlantUML + GitHub Actions + Agentic Workflows**
