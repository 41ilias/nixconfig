{ pkgs, inputs, ... }:

{
  imports = [ 
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-amd

    ./hardware-configuration.nix
    
    
    ../common/global
    ../common/users/srk
    ../common/optional/pipewire.nix
    ../common/optional/docker.nix
    ../common/optional/gnome.nix
    ../common/optional/hyprland.nix
  ];
  
  fileSystems."/".options = [ "compress=zstd" "noatime" ];
  fileSystems."/home".options = [ "compress=zstd" "noatime" ];
  fileSystems."/nix".options = [ "compress=zstd" "noatime" ];
  fileSystems."/persist".options = [ "compress=zstd" "noatime" ];
  fileSystems."/var/log".options = [ "compress=zstd" "noatime" ];
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;

  environment.systemPackages = with pkgs; [
    docker-compose  
    unar
  ];

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  networking = {
    hostName = "workstation";
    firewall.enable = false;
  };

  console = {
     font = "latarcyrheb-sun32";
     keyMap = "us";
  };

  programs = {
    dconf.enable = true;
  };
  
  sound.enable = true;

  hardware = {
    opengl.enable = true;
  };
 
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "keep";
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernelParams = [
    "video=DP-1:3840x2160@60"
  ];
  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.stateVersion = "23.05"; # Did you read the comment?

}
