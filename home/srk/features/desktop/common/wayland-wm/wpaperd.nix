{ config, lib, pkgs, ... }: {

  programs.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "/home/srk/pictures/wallpapers/2256x1504_purpule_landscape.jpg";
        apply-shadow = true;
      };

      DP-3 = {
        path = "/home/srk/pictures/wallpapers/3840x2160_purpule_landscape.jpeg";
        apply-shadow = true;
      };

      DP-4 = {
        path = "/home/srk/pictures/wallpapers/3840x2160_purpule_landscape.jpeg";
        apply-shadow = true;
      };
    };
  };
}
