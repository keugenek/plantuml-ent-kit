---
layout: default
title: Skills Pattern
---

# Skills Pattern - Composable Agent Capabilities

The Skills Pattern organizes agent capabilities into self-contained, reusable modules that can be composed to handle complex tasks.

## Overview

![Skills Pattern](diagram.png)

## Pattern Description

Skills are specialized capability modules that encapsulate:
- Domain knowledge
- Tool access
- Execution logic
- Output formatting

An agent can invoke multiple skills to complete complex, multi-faceted tasks.

## Components

### Agent
- **Purpose**: Receives user requests and coordinates skill execution
- **Key Responsibilities**:
  - Understanding user intent
  - Selecting appropriate skills
  - Synthesizing skill outputs

### Skill Router
- **Purpose**: Routes requests to appropriate skills
- **Key Responsibilities**:
  - Skill selection based on task requirements
  - Parallel skill execution when possible
  - Result aggregation and conflict resolution

### Skills
- **Purpose**: Self-contained capability modules
- **Characteristics**:
  - Single responsibility
  - Well-defined inputs/outputs
  - Independent execution
  - Reusable across contexts

### Skill Registry
- **Purpose**: Catalog of available skills
- **Contains**: Skill definitions, capabilities, and metadata

## Example Skills

### Code Skill
```yaml
name: code
description: Write, analyze, and modify code
capabilities:
  - write_code
  - review_code
  - refactor
  - debug
tools:
  - file_read
  - file_write
  - run_tests
  - lint
```

### Research Skill
```yaml
name: research
description: Gather and synthesize information
capabilities:
  - web_search
  - document_analysis
  - fact_checking
  - summarization
tools:
  - search_web
  - read_document
  - extract_entities
```

### Data Analysis Skill
```yaml
name: data_analysis
description: Analyze and visualize data
capabilities:
  - statistical_analysis
  - visualization
  - trend_detection
  - reporting
tools:
  - query_database
  - run_python
  - create_chart
```

## Skill Composition

Skills can be composed in several ways:

| Pattern | Description | Example |
|---------|-------------|---------|
| **Sequential** | Skills run in order | Research → Analyze → Report |
| **Parallel** | Skills run simultaneously | Code + Test in parallel |
| **Conditional** | Skills based on results | If error → Debug skill |
| **Iterative** | Skills in feedback loop | Code → Review → Refine |

## Skill Definition Schema

```json
{
  "name": "skill_name",
  "description": "What this skill does",
  "triggers": ["keywords", "patterns"],
  "inputs": {
    "required": ["input1"],
    "optional": ["input2"]
  },
  "outputs": {
    "primary": "main_result",
    "artifacts": ["files", "charts"]
  },
  "tools": ["tool1", "tool2"],
  "dependencies": ["other_skill"]
}
```

## When to Use

- Building agents with diverse capabilities
- Creating reusable capability modules
- Organizing complex agent architectures
- Enabling capability composition
- Supporting multi-domain tasks

## Benefits

| Benefit | Description |
|---------|-------------|
| **Modularity** | Skills are independent units |
| **Reusability** | Use skills across different agents |
| **Testability** | Test skills in isolation |
| **Extensibility** | Add new skills without changing core |
| **Specialization** | Each skill optimized for its domain |

## Related Patterns

| Pattern | Relationship |
|---------|-------------|
| [LLM Tool Call](llm-tool-call.md) | Skills use tools internally |
| [MCP Architecture](mcp-architecture.md) | Skills can be exposed via MCP |
| [Agent Orchestration](agent-orchestration.md) | Orchestrator selects skills |
| [Tool Chaining](tool-chaining.md) | Skills may chain tools |


