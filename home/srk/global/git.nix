{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Ilias Serroukh";
    userEmail = "serroukh@gmx.com";
    extraConfig = {
      init.defaultBranch = "main";
      user.signingKey = "0x81183E9449CCADDF";
      commit.gpgsign =  true;
    };
    ignores = [ ".direnv" "result" ];
  };
}
