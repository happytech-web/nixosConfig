#!/usr/bin/env bash
set -euo pipefail

# Simple window rename logic (all windows in current session):
# - If active command is a shell (bash/zsh/fish/sh) or empty, use the directory name
# - Else use one of styles with optional icons: name | icon | name_and_icon
# - Limit to 30 chars

is_shell() {
  case "$1" in
    ''|bash|zsh|fish|sh) return 0 ;;
    *) return 1 ;;
  esac
}

truncate_name() {
  local s="$1"; local max=${2:-15}
  if [ ${#s} -gt "$max" ]; then
    printf '%s' "${s:0:max}"
  else
    printf '%s' "$s"
  fi
}

# Built-in icon map (Nerd Font / common glyphs)
icon_for() {
  case "$1" in
    nvim|vim|vi) printf '' ;;   # nf-dev-vim
    git)         printf '' ;;
    python)      printf '' ;;
    node|npm|yarn) printf '' ;;
    docker)      printf '' ;;
    kubectl|kubecolor|k) printf '' ;;
    go)          printf '' ;;
    rust|cargo)  printf '' ;;
    php)         printf '' ;;
    ruby)        printf '' ;;
    java|mvn|gradle) printf '' ;;
    htop|btop|top) printf '' ;;
    ssh)         printf '' ;;
    lazygit)     printf '' ;;
    bash|zsh|fish|sh) printf '' ;;  # terminal icon
    codex)       printf '󱚞' ;;
    opencode)    printf '󰭆'  ;;
    yazi)        printf '󰇥' ;;
    *)           printf ''  ;;
  esac
}

# Allow user overrides via tmux option @swn_custom_icons
# Format: "cmd=ICON,cmd2=ICON2"
icon_override_for() {
  local cmd="$1"; local cfg
  cfg=$(tmux show -gqv @swn_custom_icons 2>/dev/null || true)
  [ -z "$cfg" ] && return 1
  local IFS=','
  for pair in $cfg; do
    local key=${pair%%=*}
    local val=${pair#*=}
    if [ "$key" = "$cmd" ] && [ -n "$val" ]; then
      printf '%s' "$val"
      return 0
    fi
  done
  return 1
}

# Compose display name according to style and icon map
# Styles:
#  - name           => "cmd:dir"
#  - icon           => "ICON dir" (fallback to name if no icon)
#  - name_and_icon  => "ICON cmd:dir" (fallback to name if no icon)
compose_name() {
  local cmd="$1" dir="$2"
  local style
  style=$(tmux show -gqv @swn_icon_style 2>/dev/null || true)
  [ -z "$style" ] && style="icon"  # default to your requested behavior

  local icon
  if ! icon=$(icon_override_for "$cmd"); then
    icon=$(icon_for "$cmd")
  fi

  case "$style" in
    name)
      printf '%s:%s' "$cmd" "$dir"
      ;;
    icon)
      if [ -n "$icon" ]; then
        printf '%s %s' "$icon" "$dir"
      else
        printf '%s:%s' "$cmd" "$dir"
      fi
      ;;
    name_and_icon)
      if [ -n "$icon" ]; then
        printf '%s %s:%s' "$icon" "$cmd" "$dir"
      else
        printf '%s:%s' "$cmd" "$dir"
      fi
      ;;
    *)
      printf '%s:%s' "$cmd" "$dir"
      ;;
  esac
}

log_file="/tmp/simple-window-name.log"
max_len=$(tmux show -gqv @swn_max_len 2>/dev/null || true)
[ -n "$max_len" ] || max_len=15

# Rename all session windows based on their active pane
printf '[%s] run: session=%s\n' "$(date +'%F %T')" "$(tmux display-message -p '#{session_id}')" \
  >>"$log_file" 2>/dev/null || true

while IFS= read -r win_id; do
  cur_path=$(tmux display-message -p -t "$win_id" '#{pane_current_path}')
  cur_cmd=$(tmux display-message -p -t "$win_id" '#{pane_current_command}')

  if [ -z "${cur_path:-}" ]; then
    dir_name="$(basename -- "$HOME")"
  else
    dir_name="$(basename -- "${cur_path%/}")"
  fi

  basecmd="${cur_cmd##*/}"
  if is_shell "$basecmd"; then
    # Shell windows: keep plain dir for 'name' style; add icon for 'icon'/'name_and_icon'
    style=$(tmux show -gqv @swn_icon_style 2>/dev/null || true)
    [ -z "$style" ] && style="icon"
    case "$style" in
      name)
        name="$dir_name"
        ;;
      icon|name_and_icon)
        # Prefer specific shell override, then generic 'terminal'
        icon=""
        if ! icon=$(icon_override_for "$basecmd"); then
          if ! icon=$(icon_for "$basecmd"); then
            if ! icon=$(icon_override_for terminal); then
              icon=$(icon_for terminal)
            fi
          fi
        fi
        if [ -n "$icon" ]; then
          name="$icon $dir_name"
        else
          name="$dir_name"
        fi
        ;;
      *)
        name="$dir_name"
        ;;
    esac
  else
    name="$(compose_name "$basecmd" "$dir_name")"
  fi

  name="$(truncate_name "$name" "$max_len")"
  printf '[%s] rename: win=%s cmd=%s path=%s name=%s\n' \
    "$(date +'%F %T')" "$win_id" "$basecmd" "${cur_path:-}" "$name" >>"$log_file" 2>/dev/null || true
  tmux rename-window -t "$win_id" -- "$name" 2>/dev/null || true
done < <(tmux list-windows -F '#{window_id}')
