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
      /settings/xdg/xdg.nix

      /networking/network.nix

      /wm/hyprland.nix
      #/wm/plasma.nix
      /sh.nix

      /utils/nix-ld.nix

      /apps/virtualization.nix
      /apps/sql/sql.nix
      /apps/sql/mongodb/mongodb.nix
      /apps/nix-lang-server/nixd.nix
    ];


  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # kernel version default in 2025-03 will install 6.6.80
  # boot.kernelPackages = pkgs.linuxPackages_6_6;



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
    git
    google-chrome
    # emacs
    # emacs-pgtk
    fira-code
    lxgw-wenkai
    # nil
  ];

  fonts.packages = with pkgs; [
    fira-code
    lxgw-wenkai
    nerd-fonts.fira-code
  ];


  system.stateVersion = "25.05"; # Did you read the comment?
}
