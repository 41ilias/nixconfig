{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./qutebrowser.nix
    ./zathura.nix
  ];
  
  home.packages = with pkgs; [ 
    cinnamon.nemo
    google-chrome
    pavucontrol
    webcord-vencord
    powerstat
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.lightly
    qt6Packages.qt6ct
    (catppuccin-kvantum.override {
      accent = "Teal";
      variant = "Mocha";
    })

    #---
    gns3-gui
    gns3-server
    ciscoPacketTracer8
  ];

  gtk = {
    enable = true;

    font = {
      name = "Fira Sans";
      size = 13;
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
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      package = pkgs.catppuccin-kvantum;
      name = "kvantum";
    };
  };

  # TODO: doesnt' seemm to work, I had to open Kvantum and set the theme manually
  xdg.configFile = {
    "Kvantum/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal.kvconfig".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Teal/Cattpuccin-Mocha-Teal.kvconfig";
    "Kvantum/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal/Catppuccin-Mocha-Teal.svg".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Teal/Cattpuccin-Mocha-Teal.svg";
  };
}
