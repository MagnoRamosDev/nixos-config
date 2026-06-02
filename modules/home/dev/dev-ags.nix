{ inputs, pkgs, ... }:
{
  # Importa o módulo do AGS vindo do flake
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # Se você for deixar seu código fonte em ~/.config/ags, deixe como null.
    # Caso vá colocar em outra pasta, mude o caminho aqui (ex: ../../ags)
    configDir = null;

    # Pacotes e bibliotecas Astal que o seu painel/shell vai precisar
    extraPackages = with pkgs; [
      inputs.astal.packages.${pkgs.system}.battery
      inputs.astal.packages.${pkgs.system}.network
      inputs.astal.packages.${pkgs.system}.tray
      inputs.astal.packages.${pkgs.system}.mpris
      inputs.astal.packages.${pkgs.system}.wireplumber

      # Ferramentas extras que você pode querer rodar no JavaScript
      fzf
    ];
  };

  # Se quiser ferramentas de linha de comando do Astal (como o notifd)
  home.packages = [
    inputs.astal.packages.${pkgs.system}.notifd
  ];
}
