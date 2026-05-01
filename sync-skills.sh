#!/usr/bin/env bash
# Syncs ~/.config/ai/skills/ → ~/.claude/skills/ so Claude Desktop sees real files.
set -euo pipefail

SRC="$HOME/.config/ai/skills/"
DST="$HOME/.claude/skills/"

rsync -a --delete \
  --exclude='.git/' \
  --exclude='.gitignore' \
  --exclude='.DS_Store' \
  --exclude='.claude/' \
  "$SRC" "$DST"
