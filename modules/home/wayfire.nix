{ pkgs, ... }:

{
  xdg.configFile."wayfire.ini".text = ''
    [core]
    plugins = autostart command vswitch move resize grid switcher window-rules animate wobbly decoration

    [input]
    xkb_layout = br
    xkb_model = abnt2

    [switcher]
    next_view = <alt> KEY_TAB

    [autostart]
    waybar = waybar
    swaync = swaync
    polkit = ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1
    wallpaper = mpvpaper -o "loop no-audio" '*' ~/Videos/wallpaper.mp4
    cliphist_store = cliphist store &
    cliphist_watch = wl-paste --type text --watch cliphist store &

    [command]
    command_launcher = nwg-drawer
    binding_launcher = <super>
    command_vol_up = swayosd-client --output-volume raise
    binding_vol_up = KEY_VOLUMEUP

    [window-rules]
    ow_no_decorations = title is "Overwatch"
    ow_no_decorations_action = remove-decorations
    ow_fullscreen = title is "Overwatch"
    ow_fullscreen_action = fullscreen

    [output:DP-1]
    mode = 1920x1080@165.001007
    vrr = true
  '';
}
