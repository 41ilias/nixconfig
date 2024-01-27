{ inputs, lib, pkgs, config, outputs, ... }:

{
  imports = [
    ./xdg.nix
    ./neovim.nix
    ./gpg
    ./git.nix
    ../features/cli
    ./direnv.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "srk";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages = with pkgs; [
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    eza # Better ls
    trashy # in order to disable rm
    wget
    curl
    zip
    unzip
    unar
    cryptsetup
    aichat
    xdg-utils
    kooha
    mpv
    ansible
    lsof
    remmina
    parsec-bin
    netcat-gnu
    discord
    obsidian
    bottom
    # (catppuccin-kvantum.override {
    #   accent = "Mauve";
    #   variant = "Mocha";
    # })
    xwaylandvideobridge
  ];
}
