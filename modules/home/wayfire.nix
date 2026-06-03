{ pkgs, ... }:

{

  xdg.configFile."wayfire.ini".text = ''
    [core]
    plugins = autostart command vswitch move resize grid switcher window-rules animate wobbly decoration shortcuts-inhibit wm-actions

    [input]
    xkb_layout = br
    xkb_model = abnt2

    [switcher]
    next_view = <alt> KEY_TAB

    [autostart]
    dbus_update = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wayfire

    panel = bash -c 'pgrep -x noctalia-shell || noctalia-shell'

    # waybar = waybar
    # swaync = swaync

    polkit = ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1
    # wallpaper = mpvpaper -o "loop no-audio" '*' ~/Videos/wallpaper.mp4
    cliphist_store = cliphist store
    cliphist_watch = wl-paste --type text --watch cliphist store

    [command]
    command_launcher = noctalia-shell ipc call launcher toggle
    binding_launcher = <super>

    command_terminal = ghostty
    binding_terminal = <ctrl> <alt> KEY_T

    command_vol_up = swayosd-client --output-volume raise
    binding_vol_up = KEY_VOLUMEUP

    command_print = sh -c 'grim -g "$(slurp)" - | wl-copy'
    binding_print = KEY_SYSRQ

    command_print_full = sh -c 'grim - | wl-copy'
    binding_print_full = <shift> KEY_SYSRQ

    [wm-actions]
    toggle_fullscreen = <super> KEY_F

    [output:DP-1]
    mode = 1920x1080@165001
    position = 0, 0
    transform = normal
    adaptive_sync = true
    scale = 1.0
  '';
}
