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
    shellAliases = myAliases;
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
}
