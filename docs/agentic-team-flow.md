---
layout: default
title: Agentic Team Flow
---

# Agentic Team Flow

Hybrid workflow combining human decision-making with AI agent execution. Humans control strategy; agents handle operations.

## Overview

![Agentic Team Flow](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/fix/cleanup-gitflows-doc/docs/uml/agentic-team-flow.puml)

## Pattern Description

This pattern divides responsibilities:
- **Humans**: Architecture decisions, code review, release approval
- **Agents**: CI/CD, automated checks, notifications, merges, documentation

**Automation Level:** ~80%
**Human Intervention:** Strategic decisions only

## Participants

| Role | Responsibilities |
|------|------------------|
| **Developer** | Write code, create PRs, address feedback |
| **Team Lead** | Review architecture, approve releases |
| **AI Agent** | Run checks, suggest fixes, manage merges |
| **Reviewer** | Code quality, business logic validation |

## Branch Structure

```
main (production)
 └── develop (integration)
      └── feature/* (human-created)
```

| Branch | Purpose | Created By | Merged By |
|--------|---------|------------|-----------|
| `main` | Production | - | Agent (after approval) |
| `develop` | Integration | - | Agent |
| `feature/*` | Features | Human | Agent |

## Workflow Phases

### 1. Feature Development (Human)
```bash
# Developer creates feature branch
git checkout -b feature/add-auth develop

# Developer implements changes
git add .
git commit -m "feat: add authentication"

# Developer pushes and creates PR
git push origin feature/add-auth
# → Create PR via GitHub/GitLab UI
```

### 2. Automated Review (Agent)

When PR is created, agent automatically:

```
┌──────────────────────────────────────────────────┐
│              Agent Review Pipeline               │
├──────────────────────────────────────────────────┤
│  1. Run test suite                               │
│  2. Check code style (lint, format)              │
│  3. Build project                                │
│  4. Security vulnerability scan                  │
│  5. Generate review summary                      │
│  6. Identify auto-fixable issues                 │
│  7. Apply auto-fixes (formatting, imports)       │
│  8. Notify reviewers                             │
└──────────────────────────────────────────────────┘
```

**Agent Comments on PR:**
```markdown
## 🤖 Automated Review Summary

### ✅ Checks Passed
- Unit tests: 142 passed
- Coverage: 84% (+2%)
- Build: Success (32s)

### 🔧 Auto-Fixed
- Formatted 3 files
- Sorted imports in auth.py

### ⚠️ Suggestions
- Consider adding error handling in `login()` (line 42)
- Test coverage for `logout()` is below threshold

### 👥 Ready for human review
@team-lead @senior-dev
```

### 3. Human Review (Reviewer/Lead)

Reviewer focuses on:
- Architecture alignment
- Business logic correctness
- Edge cases and error handling
- Security considerations
- Performance implications

**Review outcomes:**
- ✅ **Approve** → Agent proceeds to merge
- 📝 **Request changes** → Developer addresses feedback
- 💬 **Comment** → Discussion without blocking

### 4. Agent Merge

After human approval:
1. Agent merges PR (squash or rebase per config)
2. Deletes feature branch
3. Updates release notes
4. Notifies team via Slack/Discord

### 5. Release Cycle (Weekly)

```
Team Lead                    Agent
    │                          │
    │──── Trigger release ────>│
    │                          │──── Create release branch
    │                          │──── Compile changelog
    │                          │──── Bump version
    │<── Release ready ────────│
    │                          │
    │──── Review & approve ───>│
    │                          │──── Merge to main
    │                          │──── Create tag
    │                          │──── Deploy
    │<── 🚀 Deployed ──────────│
```

## Communication

### Slack/Discord Notifications

| Event | Channel | Priority |
|-------|---------|----------|
| PR ready for review | #code-review | Normal |
| Tests failed | #ci-alerts | High |
| Merge conflict | #dev-team | High |
| Release deployed | #releases | Normal |
| Security issue | #security | Urgent |

### GitHub/GitLab Comments

Agent posts structured comments with:
- Test results summary
- Coverage diff
- Build logs (on failure)
- Auto-fix details
- Suggested improvements

### Weekly Summary Email

```
📊 Weekly Development Summary

PRs Merged: 12
Tests Run: 1,847
Coverage: 84% (+3%)
Releases: 1 (v1.2.0)
Issues Resolved: 8

Top Contributors:
1. @developer-a (5 PRs)
2. @developer-b (4 PRs)
3. @developer-c (3 PRs)
```

## Configuration

### Agent Behavior
```yaml
agent:
  auto_fix:
    formatting: true
    imports: true
    trailing_whitespace: true
  reviews:
    generate_summary: true
    suggest_improvements: true
    max_suggestions: 5
  merge:
    strategy: squash  # or rebase, merge
    delete_branch: true
    update_changelog: true
```

### Approval Requirements
```yaml
approvals:
  required: 1
  from_code_owners: true
  dismiss_stale: true
  require_review_from:
    - team-lead
    - senior-dev
```

### Release Schedule
```yaml
release:
  schedule: "0 10 * * 1"  # Monday 10:00
  require_approval: true
  approvers:
    - team-lead
    - product-owner
```

## When to Use

✅ **Good Fit:**
- Teams of 3-10 developers
- Weekly release cycles
- Need audit trail for compliance
- Want AI assistance without full automation
- Balancing speed with oversight

❌ **Poor Fit:**
- Solo developers (overkill)
- Very large teams (need more structure)
- Continuous deployment requirements
- Teams resistant to automation

## Metrics

| Metric | Target |
|--------|--------|
| PR Review Time | < 4 hours |
| Merge to Deploy | < 1 day |
| Agent Fix Rate | > 30% of issues |
| Human Review Focus | Architecture only |
| Release Success | > 99% |

## Related Patterns

- [Agentic Git Flows](agentic-git-flows.md) — Full automation
- [Simplified GitFlow](simplified-gitflow.md) — Manual process

---

**[← Back to Git Flows Overview](git-flows.md)**

