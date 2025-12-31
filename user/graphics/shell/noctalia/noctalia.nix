{pkgs, gobal_utils, ...}:
{
  programs.noctalia-shell = {
    enable = true;
    package = gobal_utils.pkgs-unstable.noctalia-shell;
  };
}
