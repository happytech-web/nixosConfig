{ pkgs, ... }:
{
  home.packages = with pkgs;[
    cliphist
  ];

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
