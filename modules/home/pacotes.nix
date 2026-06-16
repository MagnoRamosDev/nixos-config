{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    heroic
    sublime4
    discord
    nh
    starship
    eza
    bat
    zoxide
    zed-editor
    gnome-weather
    pwvucontrol
    networkmanagerapplet
    gnome-calendar
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
