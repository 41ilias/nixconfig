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
    ./ssh.nix
    ./nnn.nix
  ];

  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    bluetuith
    glab
    libqalculate
    inetutils
    poppler_utils
    git-crypt
    file
  ];
}
