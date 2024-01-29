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

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "srk";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages = with pkgs; [
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    eza # Better ls
    trashy # in order to disable rm
    unar
    xdg-utils
    mpv
    lsof
    netcat-gnu
    bottom
    xwaylandvideobridge
  ];
}
