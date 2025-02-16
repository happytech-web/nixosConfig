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
    # fonts: todo
  };

}
