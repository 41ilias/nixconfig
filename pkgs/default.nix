{ pkgs ? import <nixpkgs> { } }: rec {

  srk-nvim = pkgs.callPackage ./srk-nvim { };
}
