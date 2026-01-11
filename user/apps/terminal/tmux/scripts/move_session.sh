#!/usr/bin/env bash

direction="$1"

if [ -z "$direction" ]; then
  exit 0
fi

python3 "$HOME/.dotfiles/user/apps/terminal/tmux/scripts/session_manager.py" move "$direction"
