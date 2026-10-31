#!/usr/bin/env bash
# install.sh — Install or symlink Overriders plugins to Omarchy plugins directory
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.config/omarchy/plugins"

mkdir -p "$TARGET_DIR"

PLUGINS=("zm.bar" "zm.clock" "zm.workspaces")

MODE="${1:-link}" # "link" (default) or "copy"

echo "==> Installing Overriders plugins to $TARGET_DIR (mode: $MODE)..."

for plugin in "${PLUGINS[@]}"; do
  SRC="$SCRIPT_DIR/$plugin"
  DEST="$TARGET_DIR/$plugin"

  if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    echo "Backing up existing $DEST..."
    mv "$DEST" "${DEST}.bak.$(date +%s)"
  fi

  if [ "$MODE" = "copy" ]; then
    echo "Copying $plugin..."
    cp -r "$SRC" "$DEST"
  else
    echo "Symlinking $plugin..."
    ln -s "$SRC" "$DEST"
  fi
done

echo "Validating plugins..."
for plugin in "${PLUGINS[@]}"; do
  omarchy plugin validate "$TARGET_DIR/$plugin"
done

echo "Restarting Omarchy shell..."
omarchy restart shell

echo "==> Done! Plugins successfully installed."
