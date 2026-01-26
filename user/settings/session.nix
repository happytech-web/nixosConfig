{config, pkgs, lib, global_utils,...}:
let
  secrets_path = global_utils.user_path + /settings/.secrets.toml;
in
{
  home.sessionVariables =
    if builtins.pathExists secrets_path
    then builtins.fromTOML (builtins.readFile secrets_path)
    else {};
}
