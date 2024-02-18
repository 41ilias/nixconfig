{ pkgs, lib, config, ... }:
let
in
{
  users.extraUsers.greeter = {
    packages = with pkgs; [

      catppuccin-cursors.mochaTeal
      catppuccin-gtk
      catppuccin-papirus-folders
    ];
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  # TODO: doesn't seem to work
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        icon_theme_name = "Papirus-Dark";
        application_prefer_dark_theme = true;
        # Doesn't seem to work
        cursor_theme_name = "Catppuccin-Mocha-Teal-Cursors";
        font_name = "FiraCode Nerd Font 17";
        theme_name = "Catppuccin-Mocha-Standard-Teal-Dark";  
      };
    };
  };

  services.greetd = {
    enable = true;
  };
}
