{ pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgs; [
    # System
    starship
    cine
    man-pages
    man-pages-posix
    # Programing
    sublime4
    pkgsUnstable.zed-editor
    nh
    # Others
    libreoffice-qt6
    teams-for-linux
    anki
    qalculate-qt
    proton-vpn
    mission-center

    gtk4
    gtk4-layer-shell
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
