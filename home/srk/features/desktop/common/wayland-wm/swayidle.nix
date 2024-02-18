{ pkgs, lib, config, ... }:

let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  pgrep = "${pkgs.procps}/bin/pgrep";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";

  isLocked = "${pgrep} -x ${swaylock}";
  lockTime = 2 * 60; # after 2 min trigger swaylock

  # Makes two timeouts: one for when the screen is not locked (lockTime+timeout) and one for when it is.
  afterLockTimeout = { timeout, command, resumeCommand ? null }: [
    { timeout = lockTime + timeout; inherit command resumeCommand; }
    { command = "${isLocked} && ${command}"; inherit resumeCommand timeout; }
  ];
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts =
      # Lock screen
      [{
        timeout = lockTime;
        command = "${swaylock} --daemonize --grace 15";
      }] ++
      # Mute mic
      (afterLockTimeout {
        timeout = 10;
        command = "${wpctl} set-source-mute @DEFAULT_AUDIO_SOURCE@ 1";
        resumeCommand = "${wpctl} set-source-mute @DEFAULT_AUDIO_SOURCE@ 0";
      }) ++
      # TODO: Turn keyboard backlight
      # (lib.optionals config.services.rgbdaemon.enable (afterLockTimeout {
      #   timeout = 20;
      #   command = "systemctl --user stop rgbdaemon";
      #   resumeCommand = "systemctl --user start rgbdaemon";
      # })) ++

      # Turn off displays (hyprland) 1 minute after swaylock
      (lib.optionals config.wayland.windowManager.hyprland.enable (afterLockTimeout {
        timeout = 60;
        command = "${hyprctl} dispatch dpms off";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }));
  };
}
