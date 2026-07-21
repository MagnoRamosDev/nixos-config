{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.wayfire
  ];

  programs.wayfire = {
    enable = true;

    xwayland.enable = true;
  };

  home-manager.users.magno = {
    xdg.configFile."wayfire.ini".text = ''
      [core]
      plugins = autostart command vswitch move resize grid switcher window-rules animate wobbly decoration shortcuts-inhibit wm-actions foreign-toplevel ipc

      [input]
      xkb_layout = br
      xkb_model = abnt2

      [switcher]
      next_view = <alt> KEY_TAB

      [autostart]
      dbus_update = dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP=wayfire

      # Inicia o serviço do Dank Material Shell ignorando dependências travadas
      dms_shell = sh -c 'killall wf-panel wf-background; sleep 2 && systemctl --user start dms.service --ignore-dependencies'

      polkit = ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1
      cliphist_store = cliphist store
      cliphist_watch = wl-paste --type text --watch cliphist store

      [command]
      # === APLICATIVOS E TERMINAL ===
      command_terminal = ghostty
      binding_terminal = <ctrl> <alt> KEY_T

      # === DANK MATERIAL SHELL INTERFACES ===
      command_launcher = dms ipc call spotlight toggle
      binding_launcher = <super>

      command_spotlight_bar = dms ipc call spotlight-bar toggle
      binding_spotlight_bar = <alt> KEY_SPACE

      command_clipboard = dms ipc call clipboard toggle
      binding_clipboard = <super> KEY_V

      command_processlist = dms ipc call processlist focusOrToggle
      binding_processlist = <super> KEY_M

      command_processlist_alt = dms ipc call processlist focusOrToggle
      binding_processlist_alt = <ctrl> <alt> KEY_DELETE

      command_settings = dms ipc call settings focusOrToggle
      binding_settings = <super> KEY_COMMA

      command_notifications = dms ipc call notifications toggle
      binding_notifications = <super> KEY_N

      command_notepad = dms ipc call notepad toggle
      binding_notepad = <super> <shift> KEY_N

      command_dash = dms ipc call dash toggle wallpaper
      binding_dash = <super> KEY_Y

      command_powermenu = dms ipc call powermenu toggle
      binding_powermenu = <super> KEY_X

      # === SEGURANÇA ===
      command_lock = dms ipc call lock lock
      binding_lock = <super> <alt> KEY_L

      # === CAPTURAS DE TELA (Usando a ferramenta do Dank) ===
      # Substitui as antigas do grim/slurp
      command_print = dms screenshot
      binding_print = KEY_SYSRQ

      command_print_full = dms screenshot full
      binding_print_full = <ctrl> KEY_SYSRQ

      command_print_win = dms screenshot window
      binding_print_win = <alt> KEY_SYSRQ

      # === CONTROLES DE ÁUDIO (Usando o OSD do Dank) ===
      command_vol_up = dms ipc call audio increment 3
      binding_vol_up = KEY_VOLUMEUP

      command_vol_down = dms ipc call audio decrement 3
      binding_vol_down = KEY_VOLUMEDOWN

      command_mute = dms ipc call audio mute
      binding_mute = KEY_MUTE

      command_micmute = dms ipc call audio micmute
      binding_micmute = KEY_MICMUTE

      command_playpause = dms ipc call mpris playPause
      binding_playpause = KEY_PLAYPAUSE

      command_next = dms ipc call mpris next
      binding_next = KEY_NEXTSONG

      command_prev = dms ipc call mpris previous
      binding_prev = KEY_PREVIOUSSONG

      # === CONTROLES DE BRILHO (Usando o OSD do Dank) ===
      command_bright_up = dms ipc call brightness increment 5 ""
      binding_bright_up = KEY_BRIGHTNESSUP

      command_bright_down = dms ipc call brightness decrement 5 ""
      binding_bright_down = KEY_BRIGHTNESSDOWN

      [wm-actions]
      toggle_fullscreen = <super> KEY_F

      [output:DP-1]
      mode = 1920x1080@165001
      position = 0, 0
      transform = normal
      adaptive_sync = true
      scale = 1.0
    '';
  };
}
