{ vimUtils }:
let
  name = "srk-nvim";
in
vimUtils.buildVimPlugin {
  inherit name;
  src = ./nvim;
}
