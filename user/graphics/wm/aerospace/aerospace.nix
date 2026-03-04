{ lib, pkgs, global_utils, ... }:
let
  aerospaceBin = "${pkgs.aerospace}/bin/aerospace";
  kittenBin = "${pkgs.kitty}/bin/kitten";
  yaziBin = "${pkgs.yazi}/bin/yazi";
  workspaceStep = pkgs.writeShellScript "aerospace-workspace-step" ''
    set -eu

    direction="''${1:-}"
    current="$(${aerospaceBin} list-workspaces --focused | tr -d '[:space:]')"
    workspaces="$(${aerospaceBin} list-workspaces --monitor focused --empty no)"

    if ! printf '%s\n' "$current" | grep -Eq '^[0-9]+$'; then
      current=100
    fi

    case "$direction" in
      prev)
        target="$(printf '%s\n' "$workspaces" | awk -v current="$current" '
          /^[0-9]+$/ && $1 < current {
            if (best == "" || $1 > best) best = $1
          }
          END {
            if (best != "") print best
          }
        ')"
        if [ -z "$target" ]; then
          target=$((current - 1))
        fi
        ;;
      next)
        target="$(printf '%s\n' "$workspaces" | awk -v current="$current" '
          /^[0-9]+$/ && $1 > current {
            if (best == "" || $1 < best) best = $1
          }
          END {
            if (best != "") print best
          }
        ')"
        if [ -z "$target" ]; then
          target=$((current + 1))
        fi
        ;;
      *)
        exit 1
        ;;
    esac

    exec ${aerospaceBin} workspace "$target"
  '';
in {
  programs.aerospace = {
    enable = true;
    launchd.enable = true;
    launchd.keepAlive = true;

    userSettings = {
      after-startup-command = [ "workspace 100" ];

      gaps = {
        outer.left = 5;
        outer.bottom = 5;
        outer.top = 0;
        outer.right = 5;

        inner.horizontal = 5;
        inner.vertical = 5;
      };

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

      automatically-unhide-macos-hidden-apps = false;

      key-mapping.preset = "qwerty";

      mode.main.binding = {
        cmd-s = "exec-and-forget open -a '/Applications/Chrome.app'";
        cmd-enter = "exec-and-forget open -a '/Users/happytech/Applications/Home Manager Apps/kitty.app'";
        cmd-t = "layout floating tiling";
        cmd-backspace = "fullscreen --no-outer-gaps";
        cmd-ctrl-backspace = "macos-native-fullscreen";

        cmd-y = "exec-and-forget ${kittenBin} quick-access-terminal --detach --instance-group scratch-yazi -- ${yaziBin}";
        alt-tab = "exec-and-forget ${kittenBin} quick-access-terminal --detach --instance-group scratch-term";

        cmd-h = "focus left";
        cmd-j = "focus down";
        cmd-k = "focus up";
        cmd-l = "focus right";

        cmd-shift-h = "move left";
        cmd-shift-j = "move down";
        cmd-shift-k = "move up";
        cmd-shift-l = "move right";

        cmd-ctrl-h = "exec-and-forget ${workspaceStep} prev";
        cmd-ctrl-l = "exec-and-forget ${workspaceStep} next";

        cmd-q = "close";
      };
    };
  };
}
