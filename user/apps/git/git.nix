{config, pkgs, user_settings, ...}:
{
  home.packages = with pkgs; [ git ];
  programs.git = {
    enable = true;
    userName = user_settings.name;
    userEmail = user_settings.email;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = [ ("/home/" + user_settings.username + "/.dotfiles")
                       ("/home/" + user_settings.username + "/.dotfiles/.git") ];
    };
  };
}
