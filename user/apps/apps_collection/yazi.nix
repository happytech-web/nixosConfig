{ pkgs, global_utils, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    plugins = {
      starship = pkgs.yaziPlugins.starship;
    };

    settings = {
      opener = {
        open_pdf = [
          { run = ''zathura "$1"''; orphan = true; }
        ];
        open_pic = [
          { run = ''imv "$1"''; orphan = true; }
        ];
      };

      open = {
        prepend_rules = [
          { mime = "application/pdf"; use = "open_pdf"; }
          { mime = "image/*"; use = "open_pic"; }
        ];
      };
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
