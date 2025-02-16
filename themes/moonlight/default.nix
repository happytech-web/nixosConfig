{ pkgs, ... }:
{
  stylix = {
   image = ./background.jpg; 
   polarity = "dark";
   stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/moonlight.yaml";

  };
}
