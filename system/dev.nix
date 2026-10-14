{
  pkgs,
  config,
  ...
}: {
  # I use zsh btw
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    geteduroam

    # Terminal
    wezterm

    # Edit
    neovim
    vscode-fhs

    # Racket
    racket

    # C/C++
    clang
    clang-tools
    lldb
    cmake
    ninja
    pkg-config
    glibc
    gcc
    binutils
  ];
}
