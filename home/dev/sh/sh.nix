{
  config,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";

  myAliases = {
    # Quick navigation ".." goes up one level, "..." goes up two
    ".." = "cd ..";
    "..." = "cd ../..";

    # ls, ll, la, lt and lla come from programs.eza below

    # NixOS / Home Manager
    rebuild = "sudo nixos-rebuild switch --flake ${dotfiles}#rhiannon"; # Apply system config
    hm-switch = "home-manager switch --flake ${dotfiles}#kaijusmasher"; # Apply home config
    nix-fmt = "alejandra ${dotfiles}"; # Format all .nix files in the repo

    # Git shortcuts
    g = "git";
    gs = "git status -sb"; # Short status with branch info
    gl = "git log --oneline --graph --decorate -20"; # Last 20 commits as a graph
  };
in {
  # ZSH: the shell itself
  programs.zsh = {
    enable = true;

    # Tab completion for commands, flags and paths
    enableCompletion = true;

    # Greyed-out suggestion from your history as you type
    # Press Right Arrow (or End) to accept it
    autosuggestion.enable = true;

    # Colors commands as you type: valid commands look normal,
    # unknown ones turn red, so you catch typos before pressing Enter
    syntaxHighlighting.enable = true;

    # Type the start of a command, then press Up/Down to cycle only through
    # history entries containing it Example: type "git" and press Up
    historySubstringSearch.enable = true;

    # Typing just a directory name (e.g. "Documents") cd´s into it
    autocd = true;

    shellAliases = myAliases;

    setOptions = [
      # cd pushes the old directory onto a stack. Use "dirs -v" to list it
      # and "cd -2" to jump back to entry 2. "cd -<TAB>" also lists them
      "AUTO_PUSHD"
      "PUSHD_IGNORE_DUPS"
      "PUSHD_SILENT"
      # Allow # comments at the prompt, handy for pasting commented snippets
      "INTERACTIVE_COMMENTS"
      "NO_BEEP"
    ];

    history = {
      size = 50000;
      save = 50000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreAllDups = true; # Keep only the newest copy of a repeated command
      ignoreSpace = true; # Commands starting with a space aren't saved
      share = true; # Share history between open shells
      extended = true; # Save timestamps and durations (see them with "history -i")
    };

    initContent = ''
      # Tab completion ignores case ("doc<TAB>" finds "Documents") and shows
      # a menu you can move through with the arrow keys
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu select
    '';
  };

  # Starship: the prompt
  # The look is configured in starship.toml next to this file
  programs.starship.enable = true;

  # Symlinked to the repo instead of being copied into the Nix store,
  # starship.toml changes apply instantly without a rebuild this way
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/dev/sh/starship.toml";

  # fzf: fuzzy finder, adds three keybindings to the shell:
  #  Ctrl-R  fuzzy search command history
  #  Ctrl-T  fuzzy pick a file and paste its path at the cursor
  #  Alt-C   fuzzy pick a sub-directory and cd into it
  # It also gives "**<TAB>" completion, e.g. "nvim **<TAB>" to pick a file
  # Inside fzf: type to filter, Up/Down to move, Enter to select, Esc to cancel
  programs.fzf = {
    enable = true;
    # Use fd for listing files: faster and respects .gitignore
    defaultCommand = "fd --type f --hidden --exclude .git";
    defaultOptions = ["--height 40%" "--layout=reverse" "--border"];
    # Ctrl-T shows a syntax-highlighted preview of the file
    fileWidget.options = ["--preview 'bat --color=always --style=numbers --line-range=:200 {}'"];
    changeDirWidget = {
      command = "fd --type d --hidden --exclude .git";
      # Alt-C shows a tree preview of the directory
      options = ["--preview 'eza --tree --level=2 --color=always {}'"];
    };
  };

  # zoxide: a smarter "cd" that learns the visited directories
  #  z proj    jumps to the most-used directory matching "proj"
  #  zi proj   same, but opens an fzf menu to pick from the matches
  # It only knows directories already visited at least once.
  programs.zoxide.enable = true;

  # eza: modern replacement for ls. Provides these commands:
  #   ls   basic listing        ll   long listing
  #   la   include hidden       lla  long + hidden
  #   lt   tree view
  programs.eza = {
    enable = true;
    icons = "auto"; # File-type icons, needs JetBrainsMono Nerd Font
    git = true; # Show git status per file in long listings
  };

  # bat: cat with syntax highlighting and line numbers
  #   bat file.cpp      view a file
  #   bat -p file.cpp   plain output without line numbers or borders
  # Also used by the fzf Ctrl-T preview above
  programs.bat.enable = true;

  # fd: simpler, faster find
  #   fd main           files with "main" in the name
  #   fd -e cpp         all .cpp files
  # Skips hidden and .gitignore'd files by default, add -H / -I to include them
  programs.fd.enable = true;

  # ripgrep: much faster grep that searches file contents recursively.
  #   rg "TODO"         search the current directory
  #   rg -t cpp "foo"   only search C++ files
  #   rg -i "foo"       ignore case
  programs.ripgrep.enable = true;
}
