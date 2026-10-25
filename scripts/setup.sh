#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_DIR="${HOME}/.agents"
mkdir -p "$AGENTS_DIR"

if [[ ! -f "$AGENTS_DIR/AGENTS.md" ]]; then
  cp "$ROOT/templates/AGENTS.md" "$AGENTS_DIR/AGENTS.md"
  echo "created $AGENTS_DIR/AGENTS.md"
else
  echo "keep existing $AGENTS_DIR/AGENTS.md"
fi

# Prefer PROGRESS.md; also accept Chinese filename 进度.md if user already has it
if [[ ! -f "$AGENTS_DIR/PROGRESS.md" && ! -f "$AGENTS_DIR/进度.md" ]]; then
  cp "$ROOT/templates/PROGRESS.md" "$AGENTS_DIR/PROGRESS.md"
  echo "created $AGENTS_DIR/PROGRESS.md"
else
  echo "keep existing progress file"
fi

link_file() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "skip existing $dest"
    return
  fi
  ln "$src" "$dest" 2>/dev/null || cp "$src" "$dest"
  echo "linked/copied $dest"
}

SRC="$AGENTS_DIR/AGENTS.md"
link_file "$SRC" "$HOME/.claude/CLAUDE.md"
link_file "$SRC" "$HOME/.codex/AGENTS.md"
mkdir -p "$HOME/.github" 2>/dev/null || true
# repo-local adapters are documented; global copilot instructions optional
link_file "$SRC" "$HOME/.config/opencode/AGENTS.md" 2>/dev/null || true

cat <<EOF

Setup done.

Next:
1) Edit ~/.agents/AGENTS.md (who you are, project paths)
2) Ask any linked agent to finish a tiny task
3) Confirm ~/.agents/PROGRESS.md (or 进度.md) got a seven-field entry
4) Switch agent and say: continue the last handoff

See docs/EXTENDING.md for VS Code / Xcode / Copilot / Windsurf / JetBrains.
EOF
