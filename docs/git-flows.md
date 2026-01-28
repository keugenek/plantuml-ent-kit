---
layout: default
title: Git Workflows Overview
---

# Git Workflows & Team Flows

This catalogue describes branching strategies for different team sizes and automation levels.

## Quick Comparison

| Flow | Automation | Team Size | Release Cycle | Best For |
|------|------------|-----------|---------------|----------|
| [**Agentic Git Flows**](agentic-git-flows.md) | 100% | Any | Continuous | AI-driven development |
| [**Agentic Team Flow**](agentic-team-flow.md) | ~80% | 3-10 | Weekly | Human + AI collaboration |
| [**Simplified GitFlow**](simplified-gitflow.md) | Manual | 2-5 | Monthly | Small teams, full control |
| [**Vendor Fork Flow**](vendor-fork-flow.md) | ~60% | Any | Upstream-tied | Forked external dependencies |

---

## Agentic Git Flows

[![Agentic Git Flows](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/fix/cleanup-gitflows-doc/docs/uml/agentic-git-flows.puml)](agentic-git-flows.md)

**Full automation** — AI agents manage the entire development lifecycle autonomously.

- No human intervention required
- Continuous deployment with feature flags
- Self-healing on failures
- Complete audit trail

**→ [Read full documentation](agentic-git-flows.md)**

---

## Agentic Team Flow

[![Agentic Team Flow](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/fix/cleanup-gitflows-doc/docs/uml/agentic-team-flow.puml)](agentic-team-flow.md)

**Hybrid workflow** — Humans make decisions, agents execute.

- Human approval for all merges
- Automated testing and notifications
- Weekly release cycles
- Balance of speed and oversight

**→ [Read full documentation](agentic-team-flow.md)**

---

## Simplified GitFlow

[![Simplified GitFlow](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/fix/cleanup-gitflows-doc/docs/uml/simplified-gitflow.puml)](simplified-gitflow.md)

**Traditional approach** — Manual branching for small teams.

- Full human control
- Predictable monthly releases
- Simple and well-understood
- Minimal tooling required

**→ [Read full documentation](simplified-gitflow.md)**

---

## Vendor Fork Flow

**External dependency tracking** — Maintain forks of vendor projects (OpenWebUI, Supabase, n8n).

- Track upstream changes automatically
- Isolate customizations cleanly
- Contribute fixes back upstream
- Dual test suites (vendor + custom)

**→ [Read full documentation](vendor-fork-flow.md)**

---

## Detailed Comparison

| Aspect | Agentic Flows | Team Flow | Simplified | Vendor Fork |
|--------|---------------|-----------|------------|-------------|
| **Automation** | 100% | ~80% | 0% | ~60% |
| **Team Size** | Any | 3-10 | 2-5 | Any |
| **Release Cadence** | Continuous | Weekly | Monthly | Upstream-tied |
| **Complexity** | High | Medium | Low | High |
| **Learning Curve** | Steep | Moderate | Easy | Moderate |
| **CI/CD Required** | Yes | Yes | No | Recommended |
| **Human Oversight** | Minimal | Moderate | High | Moderate |
| **Feature Flags** | Required | Optional | Not used | Optional |
| **Merge Strategy** | Auto | Agent (after approval) | Manual | Manual + Auto sync |
| **Rollback** | Automatic | Assisted | Manual | Manual |
| **Develop Branch** | No | Yes | Yes | Optional |
| **Vendor Tracking** | No | No | No | Yes |
| **Integration Tests** | Automated | Automated | Manual | Dual (custom + upstream) |
| **E2E Tests** | Automated | Automated | Manual | Automated (custom) |

## Choosing Your Flow

### Decision Tree

```
START
  │
  ├─ Do you maintain a fork of external vendor code?
  │   │
  │   YES ──► Use VENDOR FORK FLOW
  │   │       (can combine with flows below for custom development)
  │   │
  │   NO
  │   │
  ├─ Do you need a `develop` branch?
  │   │
  │   ├─ YES if:
  │   │   • Multiple features need integration testing before release
  │   │   • QA team needs stable pre-release environment
  │   │   • Release cycles are fixed (weekly/monthly)
  │   │   • Team > 5 people working in parallel
  │   │   ──► Use SIMPLIFIED GITFLOW or AGENTIC TEAM FLOW
  │   │
  │   └─ NO if:
  │       • Continuous deployment to production
  │       • Feature flags handle incomplete features
  │       • Strong automated testing (>80% coverage)
  │       • Small team or solo developer
  │       ──► Use AGENTIC GIT FLOWS (direct to release/main)
  │
  └─ What's your automation level?
      │
      ├─ High (AI agents, full CI/CD) ──► AGENTIC GIT FLOWS
      ├─ Medium (CI/CD, some automation) ──► AGENTIC TEAM FLOW
      └─ Low (manual processes) ──► SIMPLIFIED GITFLOW
```

### Quick Reference

| Scenario | Recommended Flow | Develop Branch? | Vendor Support? |
|----------|------------------|:---------------:|:---------------:|
| AI-driven solo project | Agentic Git Flows | No | No |
| Small team, monthly releases | Simplified GitFlow | Yes | No |
| Medium team, weekly releases | Agentic Team Flow | Yes | No |
| Fork of open-source project | Vendor Fork Flow | Optional | Yes |
| Fork + team collaboration | Vendor Fork + Team Flow | Yes | Yes |
| Continuous deployment | Agentic Git Flows | No | No |
| Regulated industry (audit required) | Agentic Team Flow | Yes | No |

![Choosing Your Flow](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/fix/cleanup-gitflows-doc/docs/uml/choosing-flow.puml)

---

## CI/CD by Flow

| Flow | Integration Tests | E2E Tests | Test Environment |
|------|:-----------------:|:---------:|------------------|
| **Agentic Git Flows** | ✅ Automated | ✅ Automated | Staging + Pre-prod |
| **Agentic Team Flow** | ✅ Automated | ✅ Automated | Staging |
| **Simplified GitFlow** | ❌ Manual only | ❌ Manual only | Dev + Manual QA |
| **Vendor Fork Flow** | ✅ Dual suite | ✅ Custom | Staging |

### Testing Environment Mapping

| Environment | Purpose | Used By |
|-------------|---------|---------|
| **CI (Ephemeral)** | PR validation, unit tests | All flows |
| **Dev** | Developer testing | Simplified, Team |
| **Staging** | Integration & E2E testing | Agentic, Team, Vendor |
| **Pre-prod** | Release validation | Agentic Flows |
| **Production** | Live system, smoke tests | All flows |

---

## Migration Paths

### Simplified → Team Flow
1. Introduce CI/CD pipeline
2. Add automated testing
3. Deploy AI agent for reviews
4. Gradually automate merges

### Team Flow → Agentic
1. Increase test coverage to >80%
2. Implement feature flags
3. Add automatic rollback
4. Remove human approval gates
5. Monitor and tune

## PlantUML Sources

All diagrams are maintained as PlantUML files:

| Flow | Source |
|------|--------|
| Agentic Git Flows | [uml/agentic-git-flows.puml](uml/agentic-git-flows.puml) |
| Agentic Team Flow | [uml/agentic-team-flow.puml](uml/agentic-team-flow.puml) |
| Simplified GitFlow | [uml/simplified-gitflow.puml](uml/simplified-gitflow.puml) |
| Vendor Fork Flow | [uml/vendor-fork-flow.puml](uml/vendor-fork-flow.puml) |

---

*Last Updated: 2026-01-28*

