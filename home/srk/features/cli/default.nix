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
  ];

  programs.zoxide.enable = true;
}
