{ inputs, pkgs, ... }:
{
  services.keyd = {
    enable = true;
    keyboards = { 
      default = {
        ids = [ "0001:0001" ];
        settings = {
          main = {
            capslock = "overload(capslock, esc)";
            esc = "capslock";
          };
          "capslock:C" = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            p = "up";
            n = "down";
            tab = "macro(7480525 enter)";
          };
        };
      };
    };
  };
}
