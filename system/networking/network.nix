{ lib, pkgs, system_settings, ...}: {

  networking = {
    hostName = system_settings.hostname;
    networkmanager.enable = true;
  };

  # install clash 
  environment.systemPackages = with pkgs; [
    clash-verge-rev
  ];

  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    autoStart = true;
  };

  # make sure nix-daemon knows the proxy
  networking.proxy.default = "http://127.0.0.1:7897";

  systemd.services.nix-daemon = {
    environment = {
      http_proxy = "http://127.0.0.1:7897";
      https_proxy = "http://127.0.0.1:7897";
      all_proxy = lib.mkForce "socks5://127.0.0.1:7897";
    };
  };

  networking.proxy.noProxy = "mirror.sjtu.edu.cn,mirrors.ustc.edu.cn,mirrors.tuna.tsinghua.edu.cn";
  
}
