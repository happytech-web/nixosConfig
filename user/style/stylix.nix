{ pkgs, lib, inputs, global_utils,... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    (global_utils.root_path + /themes/ophelia)
  ];

  home.packages = with pkgs; [
    base16-schemes
  ];

  stylix.targets.waybar.enable = false;
  stylix.targets.emacs.enable = false;

  stylix = {
    enable = true;
    autoEnable = true;
    # fonts: todo

    cursor = {
      package = pkgs.bibata-cursors;
      size = 24;
      name = "Bibata-Modern-Classic";
    };

    fonts = rec {
      # packages =  with pkgs; [
      #   fira-code
      #   lxgw-wenkai
      #   fira-code-nerdfont
      # ];
      # monospace = {
      #   name = "FiraCode Nerd Font";
      #   package = global_utils.pkgs-unstable.nerd-fonts.fira-code;
      #   # name = "Fira Code";
      #   # package = pkgs.fira-code;
      # };

      sansSerif = {
        name = "LXGW WenKai";
        package = pkgs.lxgw-wenkai;
      };

      serif = sansSerif;

      # emoji = {
      #   name = "Noto Color Emoji";
      #   package = pkgs.noto-fonts-emoji-blob-bin;
      #   # name = "FiraCode Nerd Font";
      #   # package = pkgs.fira-code-nerdfont;
      # };
    };

    opacity = {
      applications = 0.75;
      desktop = 0.75;
      popups = 0.85;
      terminal = 0.75;
    };
  };

}
