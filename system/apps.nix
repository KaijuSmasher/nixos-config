{
  pkgs,
  config,
  ...
}: {
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    discord
    spotify
    obsidian
    anki-bin
    ani-cli
    manga-tui
  ];
}
