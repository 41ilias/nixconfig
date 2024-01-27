{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
    ./nushell.nix
    ./fzf.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.zoxide.enable = true;
}
