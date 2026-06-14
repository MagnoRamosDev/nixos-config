{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    wl-clipboard
    slurp
    obsidian
    rclone
    gamescope
    teams-for-linux
    zapzap
    solaar
    grim
    swappy
    qalculate-gtk
    (callPackage ../packages/proton-drive.nix { })
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
