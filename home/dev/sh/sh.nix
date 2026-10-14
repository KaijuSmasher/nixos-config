{
  config,
  pkgs,
  ...
}: let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = myAliases;

    history = {
       size = 50000;
       save = 50000;
       path = "${config.xdg.dataHome}/zsh/history";
       ignoreAllDups = true;
       ignoreSpace = true;	# Commands starting with a space aren't saved
       share = true; 		# Share history between open shells
    };
  };

  programs.starship.enable = true;

  xdg.configFile."starship.toml".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/dev/sh/starship.toml";

  # Companions that make zsh much nicer
  programs.fzf.enable = true;		# Ctrl-R fuzzy history, Ctrl-T  directory/file, Alt-C sub-directory
  programs.zoxide.enable = true;	# Smarter "cd", use "z" or "zi"
}
