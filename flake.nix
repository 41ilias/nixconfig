{
  description = "srk NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    ags.url = "github:Aylur/ags";
    
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { flake-parts, self, nixpkgs, home-manager, ...}@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      

      nixosConfigurations = {
        workstation =  lib.nixosSystem {
          modules = [ ./hosts/workstation ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # Desktops
        "srk@workstation" = lib.homeManagerConfiguration {
          modules = [ ./home/srk/workstation.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
