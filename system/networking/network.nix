{ lib, pkgs, system_settings, ...}: {

  networking = {
    hostName = system_settings.hostname;
    networkmanager.enable = true;
  };

  # install clash
  environment.systemPackages = with pkgs; [
    clash-verge-rev
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "clash-verge-rev-1.7.7"
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

  # networking.proxy.noProxy = "mirror.sjtu.edu.cn,mirrors.ustc.edu.cn,mirrors.tuna.tsinghua.edu.cn";

  # set substituters
  nix.settings.substituters = [
    "https://cache.nixos.org"
    # "https://mirror.sjtu.edu.cn/nix-channels/store"
    # "https://mirrors.ustc.edu.cn/nix-channels/store"
    # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

}
