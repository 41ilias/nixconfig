{ pkgs, ... }:

{
  home.packages = [
    pkgs.swappy
  ];

  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=$XDG_SCREENSHOTS_DIR
    save_filename_format=%H:%M:%S_%Y-%m-%d.png
    show_panel=true
    line_size=5
    text_size=20
    text_font=FiraCode Nerd Font
    paint_mode=blur
    early_exit=true
    fill_shape=false
  '';
}
