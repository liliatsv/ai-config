#!/bin/bash
# ============================================================
# build.sh — Single source of truth for all AI tool configs
# Run this after editing anything in agents/ or tools/
# Usage: ./build.sh
# ============================================================

set -e

# --- Config: point these at your actual project root ---
PROJECT_ROOT="${PROJECT_ROOT:-../}"   # override with: PROJECT_ROOT=/path/to/project ./build.sh
AGENTS_DIR="$(dirname "$0")/agents"
TOOLS_DIR="$(dirname "$0")/tools"

# Destination paths (relative to your project root)
CLAUDE_DEST="$PROJECT_ROOT/.claude/CLAUDE.md"
WINDSURF_DEST_DIR="$PROJECT_ROOT/.windsurf/rules"
COPILOT_DEST="$PROJECT_ROOT/.github/copilot-instructions.md"

echo "🔨 Building AI tool configs from source..."
echo "   Project root: $PROJECT_ROOT"
echo ""

# ---- 1. Claude Code → .claude/CLAUDE.md ----
mkdir -p "$(dirname "$CLAUDE_DEST")"
cat "$TOOLS_DIR/claude/wrapper.md" > "$CLAUDE_DEST"
for agent in "$AGENTS_DIR"/*.md; do
  echo "" >> "$CLAUDE_DEST"
  echo "---" >> "$CLAUDE_DEST"
  echo "" >> "$CLAUDE_DEST"
  cat "$agent" >> "$CLAUDE_DEST"
done
echo "✅ Claude Code   → $CLAUDE_DEST"

# ---- 2. Windsurf Cascade → .windsurf/rules/*.md ----
mkdir -p "$WINDSURF_DEST_DIR"
# Copy wrapper as a base rules file
cp "$TOOLS_DIR/windsurf/wrapper.md" "$WINDSURF_DEST_DIR/00-base.md"
# Copy each agent as its own rule file (Windsurf can load multiple)
for agent in "$AGENTS_DIR"/*.md; do
  filename=$(basename "$agent")
  cp "$agent" "$WINDSURF_DEST_DIR/$filename"
done
echo "✅ Windsurf       → $WINDSURF_DEST_DIR/"

# ---- 3. GitHub Copilot → .github/copilot-instructions.md ----
mkdir -p "$(dirname "$COPILOT_DEST")"
cat "$TOOLS_DIR/copilot/wrapper.md" > "$COPILOT_DEST"
for agent in "$AGENTS_DIR"/*.md; do
  echo "" >> "$COPILOT_DEST"
  echo "---" >> "$COPILOT_DEST"
  echo "" >> "$COPILOT_DEST"
  cat "$agent" >> "$COPILOT_DEST"
done
echo "✅ GitHub Copilot → $COPILOT_DEST"

echo ""
echo "✨ Done. All configs updated."
echo "   Edit agents/*.md or tools/*/wrapper.md, then re-run this script."
