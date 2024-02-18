{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
    ./fzf.nix
    ./starship.nix
    ./tmux.nix
    ./macchina.nix
    ./rbw.nix
  ];

  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    bluetuith
    glab
    libqalculate
    inetutils
  ];
}
