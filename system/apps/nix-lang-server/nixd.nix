{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
