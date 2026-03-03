{ pkgs, user_settings, global_utils, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    settings.user.name = user_settings.name;
    settings.user.email = user_settings.email;
    settings = {
      init.defaultBranch = "main";
      credential.helper =
        if pkgs.stdenv.isDarwin then "osxkeychain" else "libsecret";
      safe.directory = [
        global_utils.dotfiles_path
        (global_utils.dotfiles_path + "/.git")
      ];
    };
  };
}
