{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./waybar.nix
    ./wofi.nix
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

  # home.sessionVariables = {
  #   MOZ_ENABLE_WAYLAND = 1;
  #   QT_QPA_PLATFORM = "wayland";
  #   LIBSEAT_BACKEND = "logind";
  #   MOZ_WEBRENDER = "1";
  # };
  #
  # systemd.user.sessionVariables = {
  #   MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
  #   MOZ_WEBRENDER = "1";
  # };
}
