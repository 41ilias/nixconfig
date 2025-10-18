{ inputs, lib, pkgs, config, outputs, ... }:

{
  imports = [
    ./xdg.nix
    ./fonts.nix
    ./neovim.nix
    ./bottom.nix
    ./gpg
    ./git.nix
    ./direnv.nix
    ./zoxide.nix
    ./bat.nix
    ../features/cli
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

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
    eza # Better ls
    tldr

    jq # JSON pretty printer and manipulator
    yq # JQ for YAML/XML/TOML
    jwt-cli
    html-tidy
    trashy # in order to disable rm
    unar
    zip
    xdg-utils
    mpv
    jellyfin-ffmpeg
    lsof
    netcat-gnu
    kdePackages.xwaylandvideobridge
  ];
}
