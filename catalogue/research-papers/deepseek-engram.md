# DeepSeek Engram: Conditional Memory via Scalable N-gram Lookup

**Paper**: [Conditional Memory via Scalable Lookup: A New Axis of Sparsity for Large Language Models](https://github.com/deepseek-ai/Engram/blob/main/Engram_paper.pdf)
**Repository**: [deepseek-ai/Engram](https://github.com/deepseek-ai/Engram)
**Released**: January 2026

## Overview

![DeepSeek Engram Architecture](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/main/catalogue/research-papers/uml/deepseek-engram.puml)

## Problem Statement

Traditional LLMs waste computational resources by using neural networks to "re-derive" static factual knowledge on every inference. This creates:
- Unnecessary GPU compute for memorized facts
- High HBM (High Bandwidth Memory) requirements
- Inefficient scaling for knowledge-heavy tasks

## Core Innovation: Conditional Memory

Engram introduces **conditional memory** as a complementary axis to neural computation:

| Approach | Purpose | Complexity | Storage |
|----------|---------|------------|---------|
| Neural (MoE) | Dynamic reasoning | O(n) | HBM/GPU |
| Engram | Static knowledge lookup | O(1) | System RAM |

## Architecture Components

### 1. Tokenizer Compression
Compresses equivalent tokens to canonical forms:
- `Apple`, `apple`, `APPLE` → `apple`
- Reduces vocabulary size by **23%**
- Improves semantic density for lookups

### 2. N-gram Extractor
Extracts sliding windows of tokens (n-grams) from input sequence for hash-based lookup.

### 3. Multi-Head Hashing
Uses **K distinct hash heads** per n-gram order to reduce collisions:

```
memory_vector = concat(
    hash_head_1(ngram) → embedding_1,
    hash_head_2(ngram) → embedding_2,
    ...
    hash_head_K(ngram) → embedding_K
)
```

### 4. Embedding Lookup Table
- Stored in **system RAM** (not HBM)
- **O(1) retrieval** regardless of table size
- Learnable embeddings trained with the model

### 5. Context-Aware Gating
The gating mechanism uses context from attention layers to filter retrieved memories:
- If memory **contradicts** context → gate suppresses it
- If memory **aligns** with context → gate allows it through

This prevents hallucination from irrelevant or conflicting memorized facts.

## Key Finding: Optimal Sparsity Split

DeepSeek discovered a **U-shaped scaling law** for allocating parameters:

| Allocation | Performance |
|------------|-------------|
| 100% Neural | Baseline |
| 75-80% Neural + 20-25% Engram | **Optimal** |
| 60% Neural + 40% Engram | Suboptimal |

> "Reallocating roughly 20%–25% of the sparse parameter budget to Engram yields the best performance."

## Results (Engram-27B)

| Benchmark Type | MoE Baseline | Engram-27B | Improvement |
|----------------|--------------|------------|-------------|
| Complex Reasoning | 70% | 74% | +4% |
| Knowledge Tests | 57% | 61% | +4% |
| Code Generation | Baseline | Improved | Consistent |
| Mathematics | Baseline | Improved | Consistent |

Tested on: Big-Bench Hard, ARC-Challenge, MMLU

## Hardware Implications

| Resource | Traditional LLM | Engram LLM |
|----------|-----------------|------------|
| HBM Usage | High (all params) | Reduced (compute only) |
| System RAM | Minimal | Used for Engram tables |
| GPU Compute | All operations | Reasoning only |

This decouples memory scaling from expensive HBM, enabling larger knowledge bases at lower cost.

## When to Use

- **Knowledge-intensive applications**: Q&A systems, fact retrieval
- **Cost-sensitive deployments**: Reduce HBM requirements
- **Hybrid reasoning**: Combine memorized facts with dynamic reasoning
- **Long-context scenarios**: Offload static knowledge to RAM

## Implementation

```bash
# From DeepSeek's demo repository
pip install torch numpy transformers sympy
python engram_demo_v1.py
```

## Related Patterns

| Pattern | Relationship |
|---------|-------------|
| [Agentic RAG](../reference-architectures/agentic-rag.md) | Alternative knowledge retrieval approach |
| [MoE Architecture](https://arxiv.org/abs/2401.02954) | Neural backbone that Engram augments |

## Sources

- [DeepSeek Engram GitHub](https://github.com/deepseek-ai/Engram)
- [Tom's Hardware Coverage](https://www.tomshardware.com/tech-industry/artificial-intelligence/deepseek-touts-memory-breakthrough-engram)
- [VentureBeat Analysis](https://venturebeat.com/data/deepseeks-conditional-memory-fixes-silent-llm-waste-gpu-cycles-lost-to)
