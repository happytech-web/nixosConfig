{ pkgs, ... }:
{
  stylix = {
   image = ./background.jpg; 
   polarity = "dark";
   base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";

  };
}
