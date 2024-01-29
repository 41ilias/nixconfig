{ config, pkgs, ... }:

{
  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
	  configHome = "${config.home.homeDirectory}/.config";
	  dataHome = "${config.home.homeDirectory}/.local/share";
	  stateHome = "${config.home.homeDirectory}/.local/state";

    mimeApps.enable = true;

    systemDirs = {
      config = [ "/etc/xdg" ];
      data = [ "/usr/share" "/usr/local/share" ];
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/pictures";
      videos = "${config.home.homeDirectory}/videos";

      templates =  null;
      publicShare = null;
      music = null;

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/pictures/screenshots";
      };
    };
  };
}
