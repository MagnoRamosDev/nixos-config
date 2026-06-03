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
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
