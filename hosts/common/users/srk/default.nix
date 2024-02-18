{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.srk = {
    isNormalUser = true;
    description = "Ilias";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "i2c"
      "networkmanager"
      "docker"
      "podman"
      "git"
      "libvirtd"
    ];

    hashedPasswordFile = config.sops.secrets.srk_password.path;
    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/srk/ssh.pub) ];
    packages = [ pkgs.home-manager ];
  };

  sops.secrets.srk_password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  # WARN: If I am not mistaken this allows me to access options that I've defined in my home manager config in my
  # system nixos config (see ../../optional/greetd.nix for example)
  # home-manager.users.srk = import ../../../../home/srk/${config.networking.hostName}.nix;

  security.pam.services = { swaylock = { }; };
}
