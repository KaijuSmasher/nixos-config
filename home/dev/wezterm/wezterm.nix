{config, pkgs, ...}:
{
   home.packages = [pkgs.nerd-fonts.jetbrains-mono];

   programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      };
   
   xdg.configFile."wezterm/wezterm.lua".source =
   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/dev/wezterm/wezterm.lua";
}
