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
    webcord-vencord
    powerstat
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.lightly
    qt6Packages.qt6ct
    qt6.qtwayland
    qt5.qtwayland
    (catppuccin-kvantum.override {
      accent = "Teal";
      variant = "Mocha";
    })
    wpa_supplicant_gui_gui
  ];

  gtk = {
    enable = true;

    font = {
      name = "Fira Sans";
      size = 12;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "teal";
      };
    };

    theme = {
      name = "Catppuccin-Mocha-Standard-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Teal-Cursors";
      package = pkgs.catppuccin-cursors.mochaTeal;
      size = 32;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Teal-Cursors";
    package = pkgs.catppuccin-cursors.mochaTeal;
    size = 32;
  };

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Teal-Dark";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };

  # qt = {
  #   enable = true;
  #   platformTheme = "gtk";
  #   style.name = "adwaita-dark";
  #   style.package = pkgs.adwaita-qt;
  # };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      package = pkgs.catppuccin-kvantum;
      name = "kvantum";
    };
  };

  xdg.configFile = {
    "Kvantum/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal.kvconfig".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Teal/Cattpuccin-Mocha-Teal.kvconfig";
    "Kvantum/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal.svg".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Teal/Cattpuccin-Mocha-Teal.svg";
  };
}
