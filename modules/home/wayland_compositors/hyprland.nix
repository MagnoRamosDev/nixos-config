{ ... }:

{
  programs.hyprland.enable = true;

  home-manager.users.magno = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      settings = {
        "$terminal" = "ghostty";
        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, Q, exec, $terminal"
          "$mainMod, M, exit,"
        ];

        windowrulev2 = [
          "float, class:.*"
        ];
      };
    };
  };
}
