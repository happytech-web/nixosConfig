{ pkgs, ... }:
{
  # collection of my CLI apps
  home.packages = with pkgs; [
    disfetch fastfetch

    usbutils

    # file managing
    eza bat
    tree
    rnr                # rename in rust
    trash-cli

    # finder
    ripgrep
    fd
    fzf

    man man-pages man-pages-posix
    # tealdeer
    tlrc               # tldr in rust

    pandoc
    unzip
    zip
    unrar
    p7zip

    file
    tokei              # calculate code lines
    glow               # markdown render in tui
    htop               # system monitor
    psmisc

    # linuxKernel.packages.linux_zen.perf
    # flamegraph

    just               # simpler to run multiple commands

    mongosh # connect to mongodb
    mermaid-cli # picture drawing

    marp-cli # markdown to pdf
    glib
    librsvg

    poppler-utils
  ];

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
