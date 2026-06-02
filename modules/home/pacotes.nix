{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

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
    # swaynotificationcenter
    mission-center
    cliphist
    wl-clipboard
    # mpvpaper
    slurp
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        position = "top";
        barType = "simple";
      };
    };
  };
}
