{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;
    font = {
      package = lib.mkForce pkgs.fira-code;
      name = lib.mkForce "FiraCode";
      size = lib.mkForce 13;
    };
    settings = {
      # background_opacity = lib.mkForce "0.85";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.3";
      cursor_trail_start_threshold = 0;
      macos_option_as_alt = "both";
    };
    quickAccessTerminalConfig = {
      edge = "center-sized";
      lines =  "800px";
      columns = "1200px";
      hide_on_focus_loss = "yes";
      focus_policy = "exclusive";
      app_id = "scratch-kitty";
      # kitty_override = {
      #   window_padding_width=20;
      #   lines = 100;
      #   columns = 150;
      # };
    };
  };

}
