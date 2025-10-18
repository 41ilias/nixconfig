{ config, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 10000;
      icon-path = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
      border-radius = 15;
      border-color = "#94e2d5FF";
      border-size = 2;
      padding = "15";
      text-color = "#b4befeFF";
      background-color = "#1E1E2EFF";
      font = "CaskaydiaCove Nerd Font";
      layer = "overlay";
    };
  };
}
