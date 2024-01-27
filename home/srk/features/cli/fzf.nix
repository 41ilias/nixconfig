{ pkgs, lib, config, ... }:

{
  programs.fzf = {
    enable = true;
    # cappuccin-machiato theme
    colors = {
      "bg+" = "#24273a";
      bg = "#363a4f";
      spinner = "#f4dbd6";
      hl = "#ed8796";
      fg = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      "fg+" = "#cad3f5";
      prompt = "#c6a0f6";
      "hl+" = "#ed8796";
    };
  };
}
