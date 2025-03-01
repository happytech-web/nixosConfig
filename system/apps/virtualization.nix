{ pkgs, ... }:
{
  # virtualisation.vmware.host.enable = true;
  # users.extraGroups.vmware.members = [ "happytech" ];
  # environment.systemPackages = with pkgs; [
  #   vmware-workstation
  # ];
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "happytech" ];
}
