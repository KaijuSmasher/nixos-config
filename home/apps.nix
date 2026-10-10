{
  pkgs,
  config,
  ...
}: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    discord
    spotify
    obsidian
    anki-bin
    ani-cli
    manga-tui
  ];
}
