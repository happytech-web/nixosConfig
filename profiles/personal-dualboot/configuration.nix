{ config, lib, pkgs, user_settings, system_settings, global_utils, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ] ++ map (file: global_utils.system_path + file) [
      # theme
      /style/stylix.nix

      # core
      /boot/dualboot.nix

      /hardware/bluetooth.nix
      /hardware/opengl.nix
      
      /settings/media/pipewire.nix
      /settings/input/fcitx.nix
      /settings/dbus/dbus.nix

      /networking/network.nix

      /wm/hyprland.nix
      #/wm/plasma.nix
      /sh.nix

      /apps/virtualization.nix
      /apps/sql/sql.nix
      /apps/sql/mongodb/mongodb.nix
      /apps/nix-lang-server/nixd.nix
    ];


  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_6;



  users.users.${user_settings.username} = {
    isNormalUser = true;
    description = "${user_settings.username}";
    extraGroups = [ "networkmanager" "wheel" "input" ]; # Enable ‘sudo’ for the user.
  };

  # nix flake related
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    qq
    git
    google-chrome
    # emacs
    emacs29-pgtk
    fira-code
    lxgw-wenkai
    # nil
  ];

  fonts.packages = with pkgs; [
    fira-code
    lxgw-wenkai
    fira-code-nerdfont
  ];


  system.stateVersion = "24.11"; # Did you read the comment?
}

