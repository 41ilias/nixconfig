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

    obsidian
    remmina

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
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
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
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 32;
  };

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Teal-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      package = pkgs.catppuccin-kvantum;
      name = "kvantum";
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvAdapta

    [Applications]
    Catppuccin-Mocha-Teal=hyprland-share-picker
  '';
}
