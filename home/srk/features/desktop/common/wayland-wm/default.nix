{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./waybar.nix
    ./wofi.nix
    ./wpaperd.nix
    ./imv.nix
    ./mako.nix
    ./cliphist.nix
    ./swappy.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    libnotify
    grim
    slurp
    imagemagick
    wl-clipboard
    wl-clip-persist
    wf-recorder
    wl-mirror
    qt6.qtwayland
    qt5.qtwayland
    sway-audio-idle-inhibit
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_WEBRENDER = "1";
    LIBSEAT_BACKEND = "logind";
    NIXOS_OZONE_WL = "1";
    KEYID = "0x81183E9449CCADDF";
  };

  systemd.user.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # for any ozone-based browser & electron apps to run on wayland
    MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
    MOZ_WEBRENDER = "1";
  };
}
