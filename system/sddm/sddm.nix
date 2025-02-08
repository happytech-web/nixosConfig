{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = [ pkgs.sddm-astronaut ];
    theme = "sddm-astronaut";
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];
}
