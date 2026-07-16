{ pkgs, inputs, ... }:

{
  imports = [
    inputs.dms-plugin-registry.nixosModules.default
  ];

  # ==========================================
  # DANK MATERIAL SHELL
  # ==========================================
  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true;
  };

  # ==========================================
  # DANK GREETER
  # ==========================================
  services.displayManager.dms-greeter = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

    compositor.name = "hyprland";
    configHome = "/home/magno";

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "magno";
    };
    defaultSession = "hyprland";
  };

  # ==========================================
  # DANK SEARCH
  # ==========================================
  programs.dsearch = {
    enable = true;
    package = inputs.danksearch.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}
