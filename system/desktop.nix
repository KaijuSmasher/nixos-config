{
  config,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    orchis-theme
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.astra-monitor
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.tiling-shell
    gnomeExtensions.vertical-workspaces
  ];

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    cheese
    snapshot
    geary
    gnome-music
    gnome-maps
    gnome-weather
    gnome-contacts
    gnome-clocks
  ];
}
