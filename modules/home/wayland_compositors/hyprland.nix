{ ... }:

{
  programs.hyprland.enable = true;

  home-manager.users.magno = {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.enable = true;

      extraConfig = ''
        # Inicia o serviço do Dank Shell assim que o compositor abrir
        exec-once = systemctl --user start dms.service

        # Seu terminal padrão
        $terminal = ghostty
        $mainMod = SUPER

        # Atalhos essenciais
        bind = $mainMod, Q, exec, $terminal
        bind = $mainMod, M, exit,

        # Forçando modo flutuante para as janelas não quebrarem o layout do Dank
        windowrulev2 = float, class:.*
      '';
    };
  };
}
