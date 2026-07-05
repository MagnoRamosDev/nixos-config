{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # System
    starship
    pwvucontrol
    crosspipe
    mission-center
    cine
    # Shell
    quickshell
    # Games
    vesktop
    heroic
    (callPackage ../packages/hydra_launcher.nix { })
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
