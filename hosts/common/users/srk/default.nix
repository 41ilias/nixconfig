{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true;
  users.users.srk = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "docker"
      "podman"
      "git"
      "libvirtd"
    ];

    # openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/misterio/ssh.pub) ];
    # passwordFile = config.sops.secrets.misterio-password.path;
    packages = [ pkgs.home-manager ];
  };
}
