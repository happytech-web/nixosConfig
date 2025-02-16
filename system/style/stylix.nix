{ pkgs, inputs, global_utils,... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    (global_utils.root_path + /themes/moonlight)
  ];

  environment.systemPackages = with pkgs; [
    base16-schemes # color schemes
  ];

  stylix = {
    enable = true; 
    autoEnable = true;

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
      monospace = {
        name = "FiraCode Nerd Font Mono";
        package = pkgs.fira-code-nerdfont;
        # name = "FiraCode Nerd Font";
        # package = pkgs.fira-code-nerdfont;
        # name = "Fira Code";
        # package = pkgs.fira-code;
      };

      sansSerif = {
        name = "LXGW WenKai";
        package = pkgs.lxgw-wenkai;
      };

      serif = sansSerif;

      emoji = {
        name = "FiraCode Nerd Font Mono";
        package = pkgs.fira-code-nerdfont;
      };
    };

    opacity = {
      applications = 0.85;
      desktop = 0.85;
      popups = 0.85;
      terminal = 0.85;
    };
  };

  

}
