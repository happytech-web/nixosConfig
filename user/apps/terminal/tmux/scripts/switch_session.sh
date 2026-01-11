#!/usr/bin/env bash
set -euo pipefail

dir="$1"
[ -z "$dir" ] && exit 0

python3 "$HOME/.dotfiles/user/apps/terminal/tmux/scripts/session_manager.py" \
  switch-relative "$dir"
