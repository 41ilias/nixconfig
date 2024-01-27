{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./zathura.nix
    ./kdeconnect.nix
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
    swww
  ];

  gtk = {
    enable = true;
    cursorTheme.name = "Qogir";
    cursorTheme.size = 24;

    iconTheme.package = pkgs.qogir-icon-theme;
    iconTheme.name = "Qogir";


    theme.package = pkgs.qogir-theme;
    theme.name = "Qogir";
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };
}
