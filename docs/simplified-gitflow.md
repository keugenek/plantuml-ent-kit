# Simplified GitFlow

Traditional branching model for small teams preferring manual control and predictable releases.

## Overview

![Simplified GitFlow](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/fix/cleanup-gitflows-doc/docs/uml/simplified-gitflow.puml)

## Pattern Description

Classic GitFlow adapted for small teams (2-5 developers):
- Permanent `main` and `develop` branches
- Temporary feature, release, and hotfix branches
- Manual merges with pull request reviews
- Scheduled releases (weekly/monthly)

**Automation Level:** 0% (manual)
**Human Intervention:** Full control

## Branch Structure

```
main ─────●─────────────●─────────────●───── (production)
          │             │             │
          │    release/1.0    release/1.1
          │      │               │
develop ──●──────●───────────────●───────── (integration)
          │      │               │
feature/a ●──────●               │
                                 │
feature/b ────────●──────────────●
                                 │
hotfix/critical ─────────────────●──────── (emergency)
```

## Branch Types

### main (Protected)
- **Purpose:** Production-ready code
- **Lifetime:** Permanent
- **Rules:**
  - Always deployable
  - Tagged with versions (v1.0.0, v1.1.0)
  - Only accepts merges from `release/*` and `hotfix/*`
  - Requires PR approval

### develop (Integration)
- **Purpose:** Integration branch for features
- **Lifetime:** Permanent
- **Rules:**
  - Latest development code
  - Base for all feature branches
  - Receives merged features
  - Source for release branches

### feature/* (Feature Development)
- **Purpose:** Develop new features
- **Lifetime:** Temporary (per feature)
- **Naming:** `feature/add-login`, `feature/api-v2`, `feature/JIRA-123`
- **Rules:**
  - Created from `develop`
  - Merged back to `develop` via PR
  - Deleted after merge

### release/* (Release Preparation)
- **Purpose:** Prepare for production release
- **Lifetime:** Temporary (per release)
- **Naming:** `release/1.0.0`, `release/2.1.0`
- **Rules:**
  - Created from `develop`
  - Only bug fixes and version bumps
  - Merged to both `main` AND `develop`
  - Tagged on main

### hotfix/* (Emergency Fixes)
- **Purpose:** Critical production fixes
- **Lifetime:** Temporary (urgent)
- **Naming:** `hotfix/security-patch`, `hotfix/critical-bug`
- **Rules:**
  - Created from `main`
  - Merged to both `main` AND `develop`
  - Tagged immediately

## Complete Workflow

### 1. Start New Feature

```bash
# Ensure develop is up to date
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feature/add-authentication

# Work on feature
# ... make changes ...
git add .
git commit -m "feat: add user authentication"

# Keep up with develop
git fetch origin develop
git rebase origin/develop  # or merge
```

### 2. Complete Feature

```bash
# Push feature branch
git push -u origin feature/add-authentication

# Create Pull Request on GitHub/GitLab
# - Base: develop
# - Compare: feature/add-authentication
# - Request review from team

# After approval, merge (via UI or CLI)
git checkout develop
git merge --no-ff feature/add-authentication
git push origin develop

# Clean up
git branch -d feature/add-authentication
git push origin --delete feature/add-authentication
```

### 3. Prepare Release

```bash
# Create release branch
git checkout develop
git checkout -b release/1.0.0

# Update version
# Edit package.json, setup.py, etc.
git commit -am "chore: bump version to 1.0.0"

# Fix any last-minute bugs
git commit -am "fix: resolve edge case in auth"

# Update changelog
git commit -am "docs: update CHANGELOG for 1.0.0"
```

### 4. Finish Release

```bash
# Merge to main
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin main --tags

# Merge back to develop
git checkout develop
git merge --no-ff release/1.0.0
git push origin develop

# Clean up
git branch -d release/1.0.0
git push origin --delete release/1.0.0
```

### 5. Hotfix (Emergency)

```bash
# Create hotfix from main
git checkout main
git checkout -b hotfix/security-vulnerability

# Fix the issue
git commit -am "fix: patch critical security issue"

# Merge to main
git checkout main
git merge --no-ff hotfix/security-vulnerability
git tag -a v1.0.1 -m "Hotfix 1.0.1"
git push origin main --tags

# Merge to develop
git checkout develop
git merge --no-ff hotfix/security-vulnerability
git push origin develop

# Clean up
git branch -d hotfix/security-vulnerability
```

## Release Checklist

```
☐ All features merged to develop
☐ All tests passing
☐ Code review completed
☐ Version number updated
☐ CHANGELOG.md updated
☐ Documentation updated
☐ Release branch created
☐ Final testing on release branch
☐ Merged to main
☐ Version tagged
☐ Merged back to develop
☐ Release branch deleted
☐ Deployed to production
☐ Release notes published
```

## Commit Message Convention

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
| Type | Usage |
|------|-------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation |
| `style` | Formatting |
| `refactor` | Code restructuring |
| `test` | Adding tests |
| `chore` | Maintenance |

**Examples:**
```
feat(auth): add OAuth2 support
fix(api): resolve null pointer in user endpoint
docs(readme): update installation instructions
```

## Advantages & Disadvantages

### ✅ Advantages

| Benefit | Description |
|---------|-------------|
| **Simple** | Easy to understand and teach |
| **Predictable** | Clear release schedule |
| **Controlled** | Full human oversight |
| **Auditable** | Clear history via merge commits |
| **Low Tooling** | Works with basic git |

### ❌ Disadvantages

| Drawback | Description |
|----------|-------------|
| **Manual** | Error-prone without automation |
| **Slow** | No continuous deployment |
| **Merge Heavy** | Many merge operations |
| **Doesn't Scale** | Challenging for large teams |
| **Feature Freeze** | Required before release |

## When to Use

✅ **Good Fit:**
- Small teams (2-5 developers)
- Monthly or scheduled releases
- Simple projects
- Teams preferring manual control
- Limited CI/CD infrastructure
- Regulatory requirements for manual review

❌ **Poor Fit:**
- Large teams (>10 developers)
- Continuous deployment needs
- Rapid iteration requirements
- High automation environments

## Tips for Success

1. **Keep features small** — Easier to review and merge
2. **Merge frequently** — Avoid long-lived branches
3. **Use PR templates** — Consistent review process
4. **Automate what you can** — Tests, linting, build
5. **Document decisions** — Clear commit messages

## Related Patterns

- [Agentic Git Flows](agentic-git-flows.md) — Full automation
- [Agentic Team Flow](agentic-team-flow.md) — Human + AI hybrid

---

**[← Back to Git Flows Overview](git-flows.md)**
