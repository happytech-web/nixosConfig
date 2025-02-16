{ pkgs, inputs, global_utils,... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    (global_utils.root_path + /themes/moonlight)
  ];
  
  home.packages = with pkgs; [
    base16-schemes
  ];

  stylix = {
    enable = true; 
    autoEnable = true;
    # fonts: todo
  };
}
