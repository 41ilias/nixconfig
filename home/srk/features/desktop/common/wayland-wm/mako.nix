{ config, ... }:
{
  services.mako = {
    enable = true;
    iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
    backgroundColor = "#1E1E2EFF";
    borderColor = "#94e2d5FF";
    borderRadius = 15;
    borderSize = 2;
    textColor = "#b4befeFF";
    defaultTimeout = 10000;
    font = "FiraCode Nerd Font 15";
    layer = "overlay";
    padding = "15";
  };
}
