{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    sassc
    swww
    brightnessctl
    inotify-tools
    (python311.withPackages (p: [ p.python-pam ]))
  ];

  programs.ags = {
    enable = true;
    # configDir = ../../../../../../ags;
    extraPackages = with pkgs; [
      libgtop
      libsoup_3
    ];
  };
}
