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

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
  };

  system.stateVersion = 6;
}
