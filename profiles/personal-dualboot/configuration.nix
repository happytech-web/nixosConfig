{ config, lib, pkgs, user_settings, system_settings, global_utils, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ] ++ map (file: global_utils.system_path + file) [
      /boot/dualboot.nix

      /hardware/bluetooth.nix
      /hardware/opengl.nix
      
      /settings/media/pipewire.nix
      /settings/input/fcitx.nix
      /settings/dbus/dbus.nix

      /networking/network.nix

      /wm/plasma.nix
      /sh.nix
    ];


  # Set your time zone.
  time.timeZone = "Asia/Shanghai";



  users.users.${user_settings.username} = {
    isNormalUser = true;
    description = "${user_settings.username}";
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
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
    emacs
    fira-code
    lxgw-wenkai
    nil
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

