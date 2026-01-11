#!/usr/bin/env bash
set -euo pipefail

# Simple window rename logic:
# - If active command is a shell (bash/zsh/fish/sh), use the base dir name
# - Else use: "cmd:dir" where dir is the base dir name
# - Limit to 30 chars

is_shell() {
  case "$1" in
    bash|zsh|fish|sh) return 0 ;;
    *) return 1 ;;
  esac
}

basename_safe() {
  local p="$1"
  # Trim trailing slashes, then take basename
  p="${p%/}"
  basename -- "$p"
}

truncate_name() {
  local s="$1"; local max=${2:-30}
  local n=${#s}
  if (( n > max )); then
    printf '%s' "${s:0:max}"
  else
    printf '%s' "$s"
  fi
}

current_session_id=$(tmux display-message -p '#{session_id}')

# List only active panes per window in current session
tmux list-panes -a -F '#{session_id} #{?pane_active,1,0} #{window_id} #{pane_current_path} #{pane_current_command}' \
  | while IFS= read -r line; do
      sid=$(printf '%s' "$line" | awk '{print $1}')
      active=$(printf '%s' "$line" | awk '{print $2}')
      [ "$sid" = "$current_session_id" ] || continue
      [ "$active" = "1" ] || continue

      win_id=$(printf '%s' "$line" | awk '{print $3}')
      # Extract the rest safely (path may have spaces, so strip first 3 fields)
      rest=${line#* * * }
      pane_path=$(printf '%s' "$rest" | awk '{print $1}')
      pane_cmd=$(printf '%s' "$rest" | awk '{print $2}')

      dir_name=$(basename_safe "${pane_path:-~}")

      if is_shell "$pane_cmd" || [ -z "$pane_cmd" ]; then
        name="$dir_name"
      else
        name="${pane_cmd}:${dir_name}"
      fi

      name=$(truncate_name "$name" 30)

      tmux rename-window -t "$win_id" -- "$name" 2>/dev/null || true
    done

