{ pkgs, user_settings, ... }:
{
  # virtualisation.vmware.host.enable = true;
  # users.extraGroups.vmware.members = [ "happytech" ];
  # environment.systemPackages = with pkgs; [
  #   vmware-workstation
  # ];
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "happytech" ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    package = pkgs.docker_29;
  };
  users.users."${user_settings.username}".extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    qemu_full
  ];
}
