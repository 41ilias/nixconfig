# misterio77 doesn't have inputs here and he is able to call the addons with
# pkgs.inputs.firefox-addons but I can't do the same why doesn't my pkgs contain inputs?
# I have to add inputs here and then do inputs.firefox-addons.packages."x86_64-linux"
{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.srk = {
      # Here misterio77 is able to just use pkgs.inputs.firefox-addons
      extensions =  with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
	    ublock-origin
        darkreader
        youtube-shorts-block

      ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
