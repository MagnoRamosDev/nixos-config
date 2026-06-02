{ pkgs, ... }:

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
    swaynotificationcenter
    mission-center
    cliphist
    wl-clipboard
    mpvpaper
    slurp
  ];
}
