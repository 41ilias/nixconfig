{ config, lib, pkgs, ... }: {

  programs.wofi = {
    enable = true;
    package = pkgs.wofi.overrideAttrs (oa: {
    });
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
    };

    style = ''
      /* Mocha Teal */
      @define-color accent #94e2d5;
      @define-color txt #cad3f5;
      @define-color bg #24273a;
      @define-color bg2 #494d64;
      
       * {
          font-family: 'JetBrains Mono Nerd Font', monospace;
          font-size: 14px;
       }
      
       /* Window */
       window {
          margin: 0px;
          padding: 10px;
          border: 3px solid @accent;
          border-radius: 7px;
          background-color: @bg;
          animation: slideIn 0.5s ease-in-out both;
       }
      
       /* Slide In */
       @keyframes slideIn {
          0% {
             opacity: 0;
          }
      
          100% {
             opacity: 1;
          }
       }
      
       /* Inner Box */
       #inner-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
          animation: fadeIn 0.5s ease-in-out both;
       }
      
       /* Fade In */
       @keyframes fadeIn {
          0% {
             opacity: 0;
          }
      
          100% {
             opacity: 1;
          }
       }
      
       /* Outer Box */
       #outer-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
       }
      
       /* Scroll */
       #scroll {
          margin: 0px;
          padding: 10px;
          border: none;
       }
      
       /* Input */
       #input {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @accent;
          background-color: @bg2;
          animation: fadeIn 0.5s ease-in-out both;
       }
      
       /* Text */
       #text {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @txt;
          animation: fadeIn 0.5s ease-in-out both;
       }
      
       /* Selected Entry */
       #entry:selected {
         background-color: @accent;
       }
      
       #entry:selected #text {
          color: @bg2;
       }
    '';
  };

  home.packages =
    let
      inherit (config.programs.password-store) package enable;
    in
    lib.optional enable (pkgs.pass-wofi.override { pass = package; });
}
