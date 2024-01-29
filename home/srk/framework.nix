{ pkgs, inputs, outputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
