{ pkgs, global_utils, ... }:
{
  home.packages = with global_utils.pkgs-unstable; [
    rustc
    cargo
    rust-analyzer
  ];
}
