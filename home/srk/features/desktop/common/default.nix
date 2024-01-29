{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./zathura.nix
  ];
  
  home.packages = with pkgs; [ 
    cinnamon.nemo
    google-chrome
    grim
    slurp
    wl-gammactl
    wl-clipboard
    wf-recorder
    hyprpicker
    wayshot
    swappy
    slurp
    imagemagick
    pavucontrol
    brightnessctl
    light
  ];

  gtk = {
    enable = true;
    cursorTheme.name = "Qogir";
    cursorTheme.size = 20;

    iconTheme.package = pkgs.qogir-icon-theme;
    iconTheme.name = "Qogir";


    theme.package = pkgs.qogir-theme;
    theme.name = "Qogir";

    font.name = "Fira Code";
    font.size = 10;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };
}
