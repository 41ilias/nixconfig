{ pkgs, config, lib, ... }:

{
  programs.rbw = {
    enable = true;
    settings = {
      email = "iliasserroukhmardi@gmail.com";
      base_url = "https://vaultwarden.srkhome.com";
      pinentry =
        if config.gtk.enable
        then pkgs.pinentry-gnome3
        else pkgs.pinentry-tty;
      };
  };

  home.packages = with pkgs; [
    rofi-rbw-wayland
  ];
}
