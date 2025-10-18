{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./qutebrowser.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    nemo
    google-chrome
    pavucontrol
    webcord-vencord
    powerstat
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.lightly
    qt6Packages.qt6ct
    (catppuccin-kvantum.override {
      accent = "teal";
      variant = "mocha";
    })

    marp-cli
    obsidian
    remmina
    onlyoffice-bin
    httpie-desktop

    #---
    ledger-live-desktop
    ledger-udev-rules

    teams-for-linux

    #---
    # gns3-gui
    # gns3-server
    # ciscoPacketTracer8
  ];

  gtk = {
    enable = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 17;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "teal";
      };
    };

    theme = {
      name = "catppuccin-mocha-blue-compact+default";
      package =
        (pkgs.catppuccin-gtk.overrideAttrs {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "gtk";
            rev = "v1.0.3";
            fetchSubmodules = true;
            hash = "sha256-q5/VcFsm3vNEw55zq/vcM11eo456SYE5TQA3g2VQjGc=";
          };

          postUnpack = "";
        }).override
          {
            accents = [ "blue" ];
            variant = "mocha";
            size = "compact";
          };
    };

    # cursorTheme = {
    #   name = "Catppuccin-Mocha-Dark-Cursors";
    #   package = pkgs.catppuccin-cursors.mochaDark;
    #   size = 32;
    # };

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

  # home.pointerCursor = {
  #   name = "Catppuccin-Mocha-Dark-Cursors";
  #   package = pkgs.catppuccin-cursors.mochaDark;
  #   size = 32;
  # };

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
