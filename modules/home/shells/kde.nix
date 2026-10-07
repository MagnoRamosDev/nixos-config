{ pkgs, lib, ... }:

{
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  services.displayManager.defaultSession = "plasma";

  # Teclado brasileiro ABNT2
  services.xserver.xkb = {
    layout = "br";
    model = "abnt2";
    variant = "";
  };

  console.useXkbConfig = true;

  programs.hyprland.enable = lib.mkForce false;
  programs.wayfire.enable = lib.mkForce false;
  services.displayManager.dms-greeter.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.konsole
    kdePackages.spectacle
    kdePackages.ark
    kdePackages.filelight
  ];

  xdg.portal.enable = true;
}
