#!/usr/bin/env bash

# Run once immediately when sourced
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT="$CURRENT_DIR/rename_windows.sh"

tmux run-shell -b "$SCRIPT"

# Hook on common events
tmux set-hook -g after-select-window[simple_window_name] "run-shell -b '$SCRIPT'"
tmux set-hook -g pane-focus-in[simple_window_name]       "run-shell -b '$SCRIPT'"

