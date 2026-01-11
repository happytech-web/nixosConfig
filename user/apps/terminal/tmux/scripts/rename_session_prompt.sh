#!/usr/bin/env bash

label="$1"

if [ -z "$label" ]; then
  exit 0
fi

python3 "$HOME/.dotfiles/user/apps/terminal/tmux/scripts/session_manager.py" rename "$label"
