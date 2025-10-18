{ pkgs, ... }: {

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fira
    fira-code
    fira-code-symbols
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];
}
