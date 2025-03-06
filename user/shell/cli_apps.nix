{ pkgs, ... }:
{
  # collection of my CLI apps
  home.packages = with pkgs; [
    disfetch fastfetch
    rnr                # rename in rust
    pandoc
    tlrc               # tldr in rust
    tree
    unzip
    zip
    file               
    tokei              # calculate code lines
    glow               # markdown render in tui
    htop               # system monitor

    mongosh # connect to mongodb
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
