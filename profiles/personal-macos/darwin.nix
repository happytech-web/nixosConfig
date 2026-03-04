{ pkgs, user_settings, system_settings, ... }:

{
  nixpkgs.hostPlatform = system_settings.system;
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  users.users.${user_settings.username}.home = user_settings.homeDirectory;
  system.primaryUser = user_settings.username;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "@admin" user_settings.username ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  time.timeZone = "Asia/Shanghai";

  system = {
    keyboard = {
      enableKeyMapping = true;
      swapLeftCommandAndLeftAlt = true;
      remapCapsLockToControl = true;
    };


    defaults = {

      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };

      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
        DragLock = false;
      };

      dock = {
        autohide = true;
        magnification = true;
        # most recently used spaces
        mru-spaces = false;
        tilesize = 32;
        largesize = 96;
      };

      finder = {
        AppleShowAllExtensions = true;
        # bottom status bar
        ShowStatusBar = true;
        ShowPathbar = true;

        # default to list view
        FXPreferredViewStyle = "Nlsv";
        # full path in window title
        _FXShowPosixPathInTitle = true;
      };
    };

    stateVersion = 6;
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
