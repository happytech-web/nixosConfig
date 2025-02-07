# everything about shell

{ pkgs, ... }:
let
  myAliases = {
    ll = "ls -l";
    la = "ls -l -a";
    ".." = "cd ..";
  };
in
{
  # bash related
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  # zsh related
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
    };
  };

  # starship related
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    starship
  ];
}
