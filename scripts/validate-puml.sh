#!/bin/bash
# PlantUML Validation Script
# Validates .puml/.pu files before commit

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Validating PlantUML files..."

# Find all PlantUML files
FILES=$(find . -type f \( -name "*.puml" -o -name "*.pu" -o -name "*.plantuml" \) | grep -v node_modules || true)

if [ -z "$FILES" ]; then
    echo -e "${YELLOW}No PlantUML files found${NC}"
    exit 0
fi

ERRORS=0
VALIDATED=0

for file in $FILES; do
    echo -n "  Checking $file... "
    HAS_ERROR=0

    # Basic syntax checks
    if ! grep -q "@startuml" "$file"; then
        echo -e "${RED}FAIL${NC} - Missing @startuml"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    if ! grep -q "@enduml" "$file"; then
        echo -e "${RED}FAIL${NC} - Missing @enduml"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Error 1: Mixing participant with component
    if grep -q "participant" "$file" && grep -qE "^component|^[[:space:]]+component" "$file"; then
        echo -e "${RED}FAIL${NC} - Mixing participant (sequence) with component"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Error 2: Unicode bullets in notes (warning only)
    if grep -q "•" "$file"; then
        echo -e "${YELLOW}WARN${NC} - Unicode bullet found, consider using *"
        HAS_ERROR=1
    fi

    # Error 3: Text inside component macro with braces
    if grep -qE "component\([^)]+\)\s*\{" "$file"; then
        echo -e "${RED}FAIL${NC} - Text inside component() macro - use notes instead"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    if [ "$HAS_ERROR" -eq 0 ]; then
        echo -e "${GREEN}OK${NC}"
    fi
    VALIDATED=$((VALIDATED + 1))
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Validated: ${GREEN}$VALIDATED${NC} | Errors: ${RED}$ERRORS${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}Validation failed!${NC}"
    exit 1
fi

echo -e "${GREEN}All PlantUML files validated successfully!${NC}"
exit 0
