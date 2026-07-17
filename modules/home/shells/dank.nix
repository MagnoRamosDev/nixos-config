{ ... }:

{
  # ==========================================
  # DANK MATERIAL SHELL
  # ==========================================
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };

  # ==========================================
  # DANK GREETER
  # ==========================================
  services.displayManager.dms-greeter = {
    enable = true;

    compositor.name = "hyprland";
    configHome = "/home/magno";

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  services.displayManager = {
    defaultSession = "wayfire";
  };

  # ==========================================
  # DANK SEARCH
  # ==========================================
  programs.dsearch = {
    enable = true;

    systemd = {
      enable = true;
      target = "default.target";
    };
  };
}
