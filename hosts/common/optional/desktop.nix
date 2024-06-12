{ ... }:
{
  # Apparently qt module in home-manager doesn't work with qt6 applications, so I had to do it here so qt6 applications
  # can be themed properly
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };
}
