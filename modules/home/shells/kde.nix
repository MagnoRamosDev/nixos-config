{ pkgs, lib, ... }:

{
  # KDE Plasma 6
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  # SDDM em Wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  # Plasma 6 usa Wayland por padrão
  services.displayManager.defaultSession = "plasma";

  # Desativa o stack gráfico antigo
  programs.hyprland.enable = lib.mkForce false;
  programs.wayfire.enable = lib.mkForce false;
  services.displayManager.dms-greeter.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Pacotes úteis do KDE
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

  # O módulo Plasma fornece o portal KDE apropriado.
  xdg.portal.enable = true;
}
