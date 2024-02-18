{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./fish.nix
    ./zsh.nix
    ./openssh.nix
    ./sops.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
}
