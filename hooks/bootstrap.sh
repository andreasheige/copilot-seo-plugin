#!/usr/bin/env bash
# bootstrap.sh — runs on every Copilot sessionStart via hooks.json
# Symlinks plugin scripts to a stable path so SKILL.md files can find them.
#
# Called by hooks.json with $1 = plugin root dir

set -euo pipefail

PLUGIN_DIR="${1:-}"

# If not passed as arg, discover from installed plugins
if [ -z "$PLUGIN_DIR" ]; then
  PLUGIN_DIR=$(find ~/.copilot/installed-plugins -path "*/copilot-seo/scripts" -type d 2>/dev/null \
    | head -1 | xargs -I{} dirname {} 2>/dev/null || true)
fi

if [ -z "$PLUGIN_DIR" ] || [ ! -d "$PLUGIN_DIR/scripts" ]; then
  # Not critical — exit silently, skills will degrade gracefully
  exit 0
fi

STABLE_DIR="$HOME/.local/share/copilot-seo"
mkdir -p "$STABLE_DIR"

# Symlink scripts dir to stable location (idempotent)
if [ ! -L "$STABLE_DIR/scripts" ] || [ "$(readlink "$STABLE_DIR/scripts")" != "$PLUGIN_DIR/scripts" ]; then
  ln -sf "$PLUGIN_DIR/scripts" "$STABLE_DIR/scripts"
fi

# Set up Python venv on first run (or if missing)
VENV_DIR="$STABLE_DIR/.venv"
REQUIREMENTS="$PLUGIN_DIR/requirements.txt"

if [ -f "$REQUIREMENTS" ] && command -v python3 &>/dev/null; then
  if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
  fi
  "$VENV_DIR/bin/pip" install -q -r "$REQUIREMENTS" 2>/dev/null || true
fi

# Write wrapper so SKILL.md can call `copilot-seo-python` and get the venv python
WRAPPER="$HOME/.local/bin/copilot-seo-python"
if command -v mkdir &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  printf '#!/usr/bin/env bash\nexec "%s/.venv/bin/python" "$@"\n' "$STABLE_DIR" > "$WRAPPER"
  chmod +x "$WRAPPER"
fi

exit 0
