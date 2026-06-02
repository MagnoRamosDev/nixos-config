{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # Se você for desenvolver na pasta padrão ~/.config/ags, deixe como null.
    configDir = null;

    # Injeta as bibliotecas nativas do Astal no JavaScript
    extraPackages = with pkgs; [
      inputs.astal.packages.${pkgs.system}.battery
      inputs.astal.packages.${pkgs.system}.network
      inputs.astal.packages.${pkgs.system}.tray
      inputs.astal.packages.${pkgs.system}.mpris
      inputs.astal.packages.${pkgs.system}.wireplumber
      inputs.astal.packages.${pkgs.system}.apps
      inputs.astal.packages.${pkgs.system}.notifd
    ];
  };
}
