{config, pkgs, user_settings, ...}:
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
      credential.helper = "libsecret";
      safe.directory = [ ("/home/" + user_settings.username + "/.dotfiles")
                       ("/home/" + user_settings.username + "/.dotfiles/.git") ];
    };
  };
}
