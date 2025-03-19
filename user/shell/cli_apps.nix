{ pkgs, ... }:
{
  # collection of my CLI apps
  home.packages = with pkgs; [
    disfetch fastfetch

    # file managing
    eza bat
    tree
    rnr                # rename in rust

    man man-pages man-pages-posix
    # tealdeer
    tlrc               # tldr in rust
    thefuck

    pandoc
    unzip
    zip
    file               
    tokei              # calculate code lines
    glow               # markdown render in tui
    htop               # system monitor
    psmisc

    just               # simpler to run multiple commands

    mongosh # connect to mongodb
  ];

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
