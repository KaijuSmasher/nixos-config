{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    neovim
  ];

  home.sessionVariables.EDITOR = "nvim";
  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/dev/nvim/config";
}
