{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    heroic
    sublime4
    protonup-qt
    bottles
    discord
    onlyoffice-desktopeditors
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
  ];
}
