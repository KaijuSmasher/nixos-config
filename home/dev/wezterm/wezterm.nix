{config, pkgs, ...}:
{
   home.packages = [pkgs.nerd-fonts.jetbrains-mono];

   programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      };
   
   xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/kaijusmasher/.dotfiles/home/dev/wezterm/wezterm.lua";
}
