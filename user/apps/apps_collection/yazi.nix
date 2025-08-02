{ pkgs, global_utils, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    plugins = {
      starship = pkgs.yaziPlugins.starship;
    };

    initLua = ''
      require("starship"):setup()
    '';

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "<C-g>";
          run = "escape --all";
          desc = "escape all";
        }
        {
          on = ["g" "p"];
          run = "cd ~/project";
          desc = "goto project dir";
        }
        {
          on = "<C-s>";
          run = "find --smart";
          desc = "find files";
        }
        {
          on = ["<C-h>" "m"];
          run = "help";
          desc = "help";
        }
      ];

      input.prepend_keymap = [
        {
          on = "<C-g>";
          run = "escape";
          desc = "escape";
        }
      ];
    };
  };
}
