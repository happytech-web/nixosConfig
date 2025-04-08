{ pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.neovim
  ];
}
