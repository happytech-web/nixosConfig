
{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    nil
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
