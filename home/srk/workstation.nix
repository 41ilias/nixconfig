{ inputs, outputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
  ];

  services.syncthing = {
      enable = true;
      extraOptions = [
      ];
  };
}
