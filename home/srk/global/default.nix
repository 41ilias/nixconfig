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

  programs = {
    home-manager.enable = true;
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
    mpv
    ansible
    lsof
    remmina
    netcat-gnu
    bottom
    # (catppuccin-kvantum.override {
    #   accent = "Mauve";
    #   variant = "Mocha";
    # })
    xwaylandvideobridge
  ];
}
