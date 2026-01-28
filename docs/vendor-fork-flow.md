---
layout: default
title: Vendor Fork Flow
---

# Vendor Fork Flow

For projects maintaining a fork of external vendor code (OpenWebUI, Supabase, n8n, etc.).

## Overview

This workflow enables tracking upstream changes while maintaining custom modifications. It separates vendor code from customizations for clean upgrades.

## Branch Structure

```
upstream/main (vendor's main branch - read-only mirror)
  ↓ (periodic sync)
vendor/main (our fork's tracking branch)
  ↓ (merge upstream)
main (our production with customizations)
  ↓ (branch)
feature/* (our custom features)
vendor-feature/* (contributions back upstream)
```

## Branch Types & Rules

### 1. upstream/main (Remote Tracking)
- Mirror of vendor's main branch
- Read-only, never commit directly
- Synced via `git fetch upstream`
- Used for comparing changes

### 2. vendor/main (Vendor Tracking)
- Clean copy of upstream for merging
- Receives upstream changes first
- Conflict resolution happens here
- Never contains custom code

### 3. main (Production + Customizations)
- Our production branch with custom modifications
- Tagged with our versions: `v1.0.0-custom.1`
- Receives merges from `vendor/main` (upstream sync)
- Receives merges from `feature/*` (our features)

### 4. feature/* (Custom Development)
- Our custom features and modifications
- Created from: `main`
- Naming: `feature/custom-auth`, `feature/our-branding`
- PR required for merge back to `main`

### 5. vendor-feature/* (Upstream Contributions)
- Features intended to be contributed back upstream
- Created from: `vendor/main`
- Naming: `vendor-feature/fix-bug-123`
- PR to upstream repo, then merge to our `main` after accepted

---

## Complete Workflow

### Initial Setup

```bash
# Add upstream remote
git remote add upstream https://github.com/vendor/repo.git
git fetch upstream

# Create vendor tracking branch
git checkout -b vendor/main upstream/main
git push -u origin vendor/main
```

### Syncing Upstream Changes

```bash
# Fetch latest from vendor
git fetch upstream

# Update vendor tracking branch
git checkout vendor/main
git merge upstream/main
git push origin vendor/main

# Merge to main with customizations
git checkout main
git merge vendor/main --no-ff -m "chore: sync upstream v2.5.0"

# Resolve any conflicts in custom areas
# Test thoroughly
git push origin main
```

### Custom Feature Development

```bash
# Create feature branch from main
git checkout -b feature/our-customization main

# Make changes
git add .
git commit -m "feat: add custom dashboard"

# Push and create PR to main
git push -u origin feature/our-customization
# Create PR on GitHub
```

### Contributing Back to Upstream

```bash
# Branch from clean vendor code
git checkout -b vendor-feature/fix-bug-123 vendor/main

# Make fix (keep it minimal and focused)
git add .
git commit -m "fix: resolve issue #123"

# Push and create PR to UPSTREAM repo
git push -u origin vendor-feature/fix-bug-123
# Create PR on vendor's repository

# After upstream accepts, it will come back via normal sync
```

---

## Handling Upstream Updates

### Minor Updates (patches, small features)
1. Merge directly from `vendor/main` to `main`
2. Resolve conflicts in custom areas
3. Test thoroughly
4. Deploy

### Major Updates (breaking changes)
1. Create `upgrade/v3.0` branch from `main`
2. Merge `vendor/main` with new version
3. Adapt customizations to new API
4. Full regression testing
5. Merge to `main` when stable

### Conflict Resolution Strategy
- Prefer upstream code for non-custom areas
- Keep customizations isolated (separate files/modules when possible)
- Document all deviations in `CUSTOMIZATIONS.md`

---

## CI/CD Configuration

### Pipeline Stages

| Stage | Trigger | Environment | Tests |
|-------|---------|-------------|-------|
| PR Validation | On PR | CI (ephemeral) | Unit + Custom tests |
| Upstream Sync | Weekly schedule | CI | Upstream test suite |
| Integration | On merge to main | Staging | Custom + E2E |
| Production Deploy | On tag | Production | Full suite |

### GitHub Actions Example

```yaml
name: Vendor Fork CI

on:
  pull_request:
  push:
    branches: [main, vendor/main]
  schedule:
    - cron: '0 6 * * 1'  # Weekly Monday 6am

jobs:
  custom-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install dependencies
        run: npm ci
      - name: Run unit tests
        run: npm run test:unit
      - name: Run custom tests
        run: npm run test:custom  # Our customization tests

  upstream-compatibility:
    if: github.ref == 'refs/heads/vendor/main' || github.event_name == 'schedule'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run upstream test suite
        run: npm run test:upstream  # Vendor's original test suite

  upstream-drift-check:
    if: github.event_name == 'schedule'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - name: Check drift from upstream
        run: |
          git fetch upstream
          BEHIND=$(git rev-list --count main..upstream/main)
          echo "Commits behind upstream: $BEHIND"
          if [ $BEHIND -gt 100 ]; then
            gh issue create \
              --title "⚠️ Upstream drift alert" \
              --body "Main is $BEHIND commits behind upstream. Time to sync!"
          fi
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  integration-tests:
    if: github.ref == 'refs/heads/main'
    needs: custom-tests
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to staging
        run: npm run deploy:staging
      - name: Run E2E tests
        run: npm run test:e2e
```

---

## Testing Strategy

### Dual Test Suite

| Test Suite | Purpose | When to Run |
|------------|---------|-------------|
| **Upstream Tests** | Ensure we haven't broken vendor functionality | On vendor/main updates, weekly |
| **Custom Tests** | Validate our modifications | On every PR and push |

### Test Types

| Test Type | CI | Staging | Prod |
|-----------|:--:|:-------:|:----:|
| Unit (custom) | ✅ | ❌ | ❌ |
| Unit (upstream) | ✅ | ❌ | ❌ |
| Integration | ⚠️ | ✅ | ❌ |
| E2E (custom flows) | ❌ | ✅ | ❌ |
| Smoke tests | ❌ | ✅ | ✅ |

---

## Best Practices

### Keep Customizations Isolated
```
src/
├── vendor/          # Untouched vendor code (or submodule)
├── custom/          # All our modifications
├── overrides/       # Files that override vendor behavior
└── config/          # Configuration differences
```

### Document Everything
Maintain a `CUSTOMIZATIONS.md`:
```markdown
# Customizations

## Modified Files
- `src/auth/login.js` - Added SSO support
- `src/ui/theme.css` - Custom branding

## Added Features
- Custom dashboard (`src/custom/dashboard/`)
- API extensions (`src/custom/api/`)

## Configuration Differences
- Database: PostgreSQL instead of SQLite
- Auth: SAML instead of basic auth
```

### Version Tagging
```bash
# Vendor version + our patch
git tag v2.5.0-custom.1
git tag v2.5.0-custom.2

# After major upstream sync
git tag v2.6.0-custom.1
```

---

## Advantages

- ✅ Track upstream improvements automatically
- ✅ Maintain custom modifications cleanly
- ✅ Contribute fixes back to community
- ✅ Clear separation of vendor vs custom code
- ✅ Audit trail of what we changed
- ✅ Easy to see drift from upstream

## Disadvantages

- ❌ Complex merge conflicts on major upgrades
- ❌ Requires discipline to isolate customizations
- ❌ Two test suites to maintain
- ❌ Upgrade lag if upstream moves fast
- ❌ Additional branch management overhead

---

## When to Use

### ✅ Good Fit
- Forking open-source projects (OpenWebUI, n8n, Supabase)
- Enterprise customizations of vendor software
- White-label products based on existing solutions
- Contributing improvements back upstream

### ❌ Not Ideal
- Heavy modifications that diverge significantly
- No intention to track upstream
- Vendor releases infrequently
- Small one-time forks

---

## Related

- [Git Workflows Overview](git-flows.md)
- [Agentic Git Flows](agentic-git-flows.md) - Can combine for automated custom development
- [Agentic Team Flow](agentic-team-flow.md) - Can combine for team collaboration

---

*Last Updated: 2026-01-28*
