#!/usr/bin/env bash
# validate.sh — Validate repo structure for agent or skill repositories
# Usage: bash validate.sh <path-to-repo>
#
# Reference standards:
#   Skill repo: https://github.com/coreyhaines31/marketingskills
#   Agent repo: https://github.com/vercel-labs/agent-browser

set -euo pipefail

REPO="${1:-.}"
ERRORS=0
WARNINGS=0

error() {
  echo "❌ ERROR: $1"
  ((ERRORS++)) || true
}

warn() {
  echo "⚠️  WARN: $1"
  ((WARNINGS++)) || true
}

ok() {
  echo "✅ $1"
}

if [ ! -d "$REPO" ]; then
  echo "Usage: validate.sh <path-to-repo>"
  exit 1
fi

echo "🔍 Validating: $REPO"
echo ""

# Check README.md
if [ -f "$REPO/README.md" ]; then
  ok "README.md found"
else
  error "README.md missing at root"
fi

# Check skills/ directory
if [ -d "$REPO/skills" ]; then
  ok "skills/ directory found"
  SKILL_DIRS=$(find "$REPO/skills" -maxdepth 1 -mindepth 1 -type d)
  if [ -z "$SKILL_DIRS" ]; then
    error "skills/ directory is empty — no skill subfolders found"
  else
    echo "   Found skill subfolders:"
    for d in $SKILL_DIRS; do
      name=$(basename "$d")
      echo "   📁 $name/"
      if [ -f "$d/SKILL.md" ]; then
        ok "      $name/SKILL.md present"
      else
        error "      $name/SKILL.md missing (required)"
      fi
      if [ -d "$d/examples" ]; then
        ok "      $name/examples/ present"
      else
        warn "      $name/examples/ missing (recommended)"
      fi
      if [ -d "$d/scripts" ]; then
        ok "      $name/scripts/ present"
      else
        warn "      $name/scripts/ missing (optional)"
      fi
    done
  fi
else
  error "skills/ directory missing"
fi

# Check AGENTS.md
if [ -f "$REPO/AGENTS.md" ]; then
  ok "AGENTS.md found"
else
  warn "AGENTS.md missing (recommended for agent repos)"
fi

# Check LICENSE
if [ -f "$REPO/LICENSE" ] || [ -f "$REPO/LICENSE.md" ] || [ -f "$REPO/LICENSE.txt" ]; then
  ok "LICENSE found"
else
  warn "LICENSE missing (recommended)"
fi

# Summary
echo ""
echo "========================================"
if [ "$ERRORS" -gt 0 ]; then
  echo "❌ Validation FAILED: $ERRORS error(s), $WARNINGS warning(s)"
  exit 1
else
  echo "✅ Validation PASSED: 0 errors, $WARNINGS warning(s)"
  exit 0
fi
