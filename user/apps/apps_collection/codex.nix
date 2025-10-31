{ config, pkgs, global_utils, lib, ... }:
let
  repoRoot   = "${config.home.homeDirectory}/.dotfiles";
  secretPath = "${repoRoot}/.secrets/openai.txt";
  realCodex  = "${pkgs.codex}/bin/codex";
in {
  home.packages = [
    global_utils.pkgs-unstable.codex
    # (pkgs.writeShellScriptBin "codex" ''
    #   set -euo pipefail
    #   if [ -f "${secretPath}" ]; then
    #     export OPENAI_API_KEY="$(tr -d '\r\n' < "${secretPath}")"
    #   fi
    #   exec ${realCodex} "$@"
    # '')

  ];
}
