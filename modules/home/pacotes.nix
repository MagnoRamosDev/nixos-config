{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # System
    starship
    cine
    man-pages
    man-pages-posix
    # Games
    heroic
    (callPackage ../packages/hydra_launcher.nix { })
    (callPackage ../packages/curse_forge.nix { })
    # Drives
    rclone
    (callPackage ../packages/proton_drive_cli.nix { })
    # Programing
    sublime4
    zed-editor
    nh
    # Others
    libreoffice-qt6
    obsidian
    teams-for-linux
    anki
    qalculate-qt
    ciscoPacketTracer9
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
