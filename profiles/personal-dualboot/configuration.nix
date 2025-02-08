{ config, lib, pkgs, user_settings, system_settings, global_utils, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ] ++ map (file: global_utils.system_path + file) [
      /hardware/bluetooth.nix
      /hardware/opengl.nix
      
      /settings/media/pipewire.nix
      /settings/input/fcitx.nix
      /settings/dbus/dbus.nix

      /networking/network.nix

      /wm/kde.nix
      /sh.nix
    ];

  # dual system boot config
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      extraEntries = ''
        menuentry "Windows" {
          search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
          chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";


  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "ctrl:swapcaps";


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

