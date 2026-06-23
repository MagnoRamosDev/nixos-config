{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
    mangohud
    sublime4
    nh
    starship
    eza
    bat
    zoxide
    zed-editor
    pwvucontrol
    networkmanagerapplet
    playerctl
    cliphist
    rclone
    solaar
    (callPackage ../packages/proton_drive_cli.nix { })
    (callPackage ../packages/hydra_launcher.nix { })
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
