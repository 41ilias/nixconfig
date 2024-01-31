{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./waybar.nix
    ./wofi.nix
    ./wpaperd.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    grim
    imv
    mimeo
    pulseaudio
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
    NIXOS_OZONE_WL = "1";
    MOZ_WEBRENDER = "1";
    KEYID = "0x81183E9449CCADDF";
  };

  systemd.user.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # for any ozone-based browser & electron apps to run on wayland
    MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
    MOZ_WEBRENDER = "1";
  };
}
