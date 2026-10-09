{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    wget
    alejandra
    fastfetch
  ];
}
