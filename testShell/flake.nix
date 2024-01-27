{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, ... } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShell.x86_64-linux.projectA = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {
            enterShell = ''
              echo this is project A
            '';
          }
        ];
      };
      devShell.x86_64-linux.projectB = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {
            enterShell = ''
              echo this is project B
            '';
          }
        ];
      };
    };
}
