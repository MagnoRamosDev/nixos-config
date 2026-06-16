{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    heroic
    sublime4
    vesktop
    nh
    starship
    eza
    bat
    zoxide
    zed-editor
    pwvucontrol
    networkmanagerapplet
    playerctl
    mission-center
    cliphist
    obsidian
    rclone
    gamescope
    teams-for-linux
    zapzap
    solaar
    qalculate-gtk
    (callPackage ../packages/proton_drive_cli.nix { })
    (callPackage ../packages/hydra_launcher.nix { })
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
