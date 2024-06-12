# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      inputs.hardware.nixosModules.framework-13-7040-amd

      ../common/global
      ../common/users/srk
      ../common/optional/pipewire.nix
      ../common/optional/greetd.nix
      ../common/optional/docker.nix
      ../common/optional/hyprland.nix
      ../common/optional/keyd.nix
      ../common/optional/adb.nix
      ../common/optional/desktop.nix
      ../common/optional/smbshares.nix
      ../common/optional/printer.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.firmwareLinuxNonfree ];
  hardware.enableRedistributableFirmware = true;
  hardware.i2c.enable = true;

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    powerOnBoot = false;
  };

  programs.light.enable = true;

  networking = {
    hostName = "framenomad";
    firewall.enable = false;
    extraHosts = ''
      127.0.0.1 host.docker.internal
      127.0.0.1 t3app.local
      10.0.0.8  vimsnap.local
      10.0.0.150 janus
      10.0.0.141 dugalle
      10.0.0.142 dugalle2
      10.0.0.143 raynor
      10.0.0.144 duke
    '';
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
	  "inode/directory" = [ "nemo.desktop" ];
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
    videoDrivers = [ "modesetting" ];
  };

  services.dbus = {
    enable = true;
    packages = with pkgs; [ dconf ];
  };

  services.upower.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    usbutils
    pciutils
    bluez-tools
    v4l-utils
    libvdpau
    ddcutil
    openssl_3_2

    scrcpy
  ];

  # services.softether = {
  #   enable = true;
  #   vpnclient = {
  #     enable = true;
  #   };
  # };

  services.pcscd.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  # List services that you want to enable:
  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };
  
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
