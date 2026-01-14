# LLM Context Management Principles

A comprehensive index of techniques to prevent context pollution and optimize LLM agent performance.

## Overview

![LLM Context Management](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/main/catalogue/reference-architectures/uml/llm-context-management.puml)

## The Problem: Context Degradation

LLMs suffer from several context-related issues:

| Problem | Description | Impact |
|---------|-------------|--------|
| **Context Rot** | Performance degrades as context grows | Quality drops at ~25% of max window |
| **Lost in Middle** | Information in middle of context is poorly recalled | Beginning/end bias |
| **Context Pollution** | Irrelevant data crowds out useful information | Degraded reasoning |
| **Token Limits** | Hard cap on context window size | Truncation, errors |

## Strategy Categories

### 1. Isolation Strategies

Prevent pollution by separating concerns:

#### Subagents
Each subagent gets its own clean context window:
```
Lead Agent (high-level plan)
├── Research Agent (isolated 100k context)
├── Code Agent (isolated 100k context)
└── Review Agent (isolated 100k context)
```

**Benefits:**
- Effective context = sum of all agent windows
- Each agent sees only relevant information
- Failures are isolated

#### Tool Sandboxing
Tool outputs don't pollute main conversation:
- Execute tools in isolated contexts
- Return only distilled results to main agent
- MCP servers naturally provide isolation

#### Scoped Context
Each model call sees minimum required context:
- Named, ordered context processors
- Explicit transformations (not ad-hoc concatenation)
- Scope by default

### 2. Reduction Strategies

Shrink context while preserving information:

#### Compaction (Preferred)
**Reversible** - strips redundant data that exists elsewhere:
```
Before: [full file contents in context]
After:  [reference to file path - can re-read if needed]
```

#### Summarization (Lossy)
LLM condenses history when compaction isn't enough:
- Triggers at rot threshold (e.g., 128k tokens)
- Reduces token count by 60-70%
- Keep recent tool calls in full detail

**Priority Order:**
1. Raw (keep original)
2. Compaction (reversible)
3. Summarization (only when necessary)

#### Tool Result Clearing
Remove raw tool outputs deep in history:
- Agent already processed the result
- Decision was made based on it
- Raw data no longer needed

#### Observation Masking
Target environment observations only:
- Preserve action and reasoning history in full
- Mask verbose tool outputs
- Maintain decision trail

### 3. External Memory (RAG)

Move knowledge outside the context window:

| Component | Purpose |
|-----------|---------|
| **Vector Store** | Semantic similarity search |
| **Knowledge Base** | Structured fact storage |
| **Long-term Store** | Persistent memory across sessions |

**When to use RAG vs Context:**
- Static knowledge → RAG
- Dynamic reasoning → Context
- Hybrid for best results

### 4. Windowing Strategies

Process long content in manageable chunks:

#### Sliding Window
```
[Window 1: tokens 0-4000    ]
      [Window 2: tokens 3000-7000    ]
            [Window 3: tokens 6000-10000   ]
```

#### Overlap Regions
Maintain coherence across windows:
- Typical overlap: 10-20% of window size
- Prevents information loss at boundaries

#### Chunking
Break content at semantic boundaries:
- Paragraph/section breaks
- Function/class boundaries in code
- Topic shifts in documents

### 5. Hierarchical Memory

Multi-tier storage with different characteristics:

| Tier | Content | Retention |
|------|---------|-----------|
| **Short-term** | Verbatim recent turns | 8-10 exchanges |
| **Medium-term** | Compressed summaries | Session duration |
| **Long-term** | RAG/database | Persistent |

**Implementation:**
```
Query → Check short-term → Check medium-term → RAG long-term
                ↓                   ↓                ↓
           Full detail      Summary context    Retrieved facts
```

### 6. Monitoring & Auto-Management

Proactive context management:

#### Token Counting
Track usage before hitting limits:
```python
if token_count > (max_context * 0.75):
    trigger_compaction()
```

#### Rot Threshold
Don't wait for API errors:
- Set threshold at ~25% of max context
- Quality degrades before hard limit
- Proactive summarization maintains quality

#### Auto-Compaction
Automatic context management:
1. Monitor token count
2. At threshold, analyze context
3. Apply compaction first
4. Fall back to summarization if needed

## Implementation Patterns

### Pattern 1: Customer Service Bot
```
Sliding Window (recent 8-10 messages)
    + RAG (knowledge base)
    + Periodic summarization (>20 exchanges)
```

### Pattern 2: Code Agent
```
Subagents (isolated contexts)
    + Tool result clearing
    + File reference compaction
    + External memory for docs
```

### Pattern 3: Research Agent
```
Hierarchical memory
    + RAG for sources
    + Summarization for synthesis
    + Scoped context per subtask
```

## Best Practices

1. **Compress tool outputs** - Don't add 100 rows when 5 suffice
2. **Use subagents for depth** - Isolated windows for specialized tasks
3. **Prefer compaction over summarization** - Reversibility matters
4. **Monitor proactively** - Don't wait for errors
5. **Scope by default** - Minimum context per call
6. **Keep recent full-detail** - Summarize older history

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Stuffing entire codebase | Exceeds limits, rot | Use RAG + file references |
| No summarization strategy | Quality degrades | Implement thresholds |
| Single monolithic context | Pollution spreads | Use subagents |
| Ignoring token count | Sudden failures | Monitor proactively |

## Related Patterns

| Pattern | Relationship |
|---------|-------------|
| [LLM Tool Call](llm-tool-call.md) | Tool outputs need clearing |
| [Agent Orchestration](agent-orchestration.md) | Subagent isolation |
| [Agentic RAG](agentic-rag.md) | External memory retrieval |
| [Skills Pattern](skills-pattern.md) | Scoped context per skill |

## Sources

- [Anthropic: Effective Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [JetBrains Research: Smarter Context Management](https://blog.jetbrains.com/research/2025/12/efficient-context-management/)
- [Google: Multi-Agent Framework Architecture](https://developers.googleblog.com/architecting-efficient-context-aware-multi-agent-framework-for-production/)
- [Agenta: Top Techniques to Manage Context Length](https://agenta.ai/blog/top-6-techniques-to-manage-context-length-in-llms)
- [Claude Developer Platform: Context Management](https://claude.com/blog/context-management)
