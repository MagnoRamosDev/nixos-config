{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/home/wayfire.nix
  ];

  # ==========================================
  # FLAKES E PERMISSÕES
  # ==========================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # ==========================================
  # BOOTLOADER E KERNEL
  # ==========================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ==========================================
  # REDE E SISTEMA
  # ==========================================
  networking.hostName = "magno-pc";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";
  console.keyMap = "br-abnt2";

  # ==========================================
  # ÁUDIO (PIPEWIRE) E HARDWARE
  # ==========================================
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  # ==========================================
  # INTERFACE E LOGIN
  # ==========================================
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wayfire-plugins-extra
    ];
  };
  security.polkit.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "pixie";
    package = pkgs.kdePackages.sddm;
    settings = {
      Theme = {
        CursorTheme = "breeze_cursors";
      };
    };
  };

  # ==========================================
  # SERVIÇOS DO DESKTOP
  # ==========================================
  programs.dconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # ==========================================
  # PROGRAMAS GLOBAIS E PACOTES
  # ==========================================
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.nano.enable = false;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.variables = {
    XKB_DEFAULT_LAYOUT = "br";
    XKB_DEFAULT_MODEL = "abnt2";
  };

  environment.pathsToLink = [ "/share/icons" "/share/pixmaps" ];

  environment.systemPackages = with pkgs; [
    (stdenv.mkDerivation {
      name = "pixie-sddm";
      src = fetchFromGitHub {
        owner = "xCaptaiN09";
        repo = "pixie-sddm";
        rev = "main";
        hash = "sha256-1PDWX8bJfc0HYMW9MsxWwDXDoYy5aaehUWr7FW3yR9U=";
      };
      installPhase = ''
        mkdir -p $out/share/sddm/themes/pixie
        cp -r * $out/share/sddm/themes/pixie/
      '';
    })

    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.qt5compat
    kdePackages.polkit-kde-agent-1

    waybar
    swayosd
    wlogout
    swaybg
    nwg-drawer

    nautilus
    adwaita-icon-theme
    whitesur-icon-theme
    loupe
    nautilus-python

    quickshell
    fuzzel
    libreoffice-fresh
    ghostty
    micro
    git
    wl-clipboard

    karere
    celeste
  ];

  # ==========================================
  # USUÁRIOS
  # ==========================================
  users.users.magno = {
    isNormalUser = true;
    description = "Magno";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    shell = pkgs.fish;
  };

  users.users.visitante = {
    isNormalUser = true;
    description = "Visitante";
    extraGroups = [ "video" ];
  };

  # ==========================================
  # HOME MANAGER (Configurações do Usuário)
  # ==========================================
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.magno = { pkgs, ... }: {
    home.stateVersion = "25.11";
    home.enableNixpkgsReleaseCheck = false;

    home.sessionVariables = {
      EDITOR = "subl";
      XWAYLAND_FORCE_GRAB_KEYBOARD = "1";
      SDL_VIDEODRIVER = "x11";
    };

    services.swayosd.enable = true;

    home.packages = with pkgs; [
      mangohud
      heroic
      sublime4
      protonup-qt
      bottles
      discord
      onlyoffice-desktopeditors
      nh
      starship
      eza
      bat
      zoxide
      zed-editor
      gnome-weather
      pwvucontrol
      networkmanagerapplet
      gnome-calendar
      playerctl
      swaynotificationcenter
      mission-center
      cliphist
      wl-clipboard
      zig

      # PACOTE DO WALLPAPER ANIMADO
      mpvpaper
    ];

    gtk = {
      enable = true;
      iconTheme = {
        name = "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          margin-top = 8;
          margin-left = 16;
          margin-right = 16;
          modules-left = [ "custom/launcher" "wlr/workspaces" "custom/weather" ];
          modules-center = [ "mpris" "clock" ];
          modules-right = [ "pulseaudio" "network" "battery" "custom/notification" "tray" "custom/clipboard" ];

          "custom/launcher" = {
            format = " ";
            on-click = "nwg-drawer";
            tooltip = false;
          };
          "wlr/workspaces" = {
            format = "{icon}";
            on-click = "activate";
          };
          "custom/weather" = {
            format = "{}";
            tooltip = true;
            interval = 3600;
            exec = "curl -s 'https://wttr.in/Petropolis?format=1'";
            return-type = "text";
            on-click = "gnome-weather";
          };
          "mpris" = {
            format = "{player_icon} {dynamic}";
            format-paused = "{status_icon} <i>{dynamic}</i>";
            player-icons = {
              default = "▶";
              mpv = "🎵";
              spotify = "";
              firefox = "";
            };
            status-icons = {
              paused = "⏸";
            };
            dynamic-len = 40;
          };
          "clock" = {
            format = " {:%H:%M - %d/%m}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            on-click = "gnome-calendar";
            calendar = {
              mode = "month";
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };
          "custom/clipboard" = {
            format = "";
            on-click = "fuzzel -d | cliphist decode | wl-copy";
            tooltip = false;
          };
          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-muted = " Muted";
            format-icons = {
              default = ["" "" ""];
            };
            on-click = "pwvucontrol";
            scroll-step = 5;
          };
          "network" = {
            format-wifi = "  {essid}";
            format-ethernet = "  {ipaddr}";
            format-disconnected = "⚠ Off";
            tooltip-format = "{ifname} via {gwaddr}";
            on-click = "nm-connection-editor";
          };
          "custom/notification" = {
            tooltip = false;
            format = " ";
            on-click = "swaync-client -t -sw";
            escape = true;
          };
        };
      };
      style = ''
        * { border: none; border-radius: 0; font-family: "JetBrainsMono Nerd Font", sans-serif; font-size: 15px; font-weight: bold; min-height: 0; }
        window#waybar { background: transparent; color: #cdd6f4; }
        #custom-launcher, #workspaces, #custom-weather, #mpris, #clock, #pulseaudio, #network, #battery, #custom-notification, #tray {
          background: rgba(30, 30, 46, 0.85);
          border-radius: 12px;
          margin: 4px;
          padding: 4px 16px;
          border: 2px solid #313244;
        }
        #custom-launcher { color: #89b4fa; font-size: 18px; padding-right: 18px; }
        #workspaces button { color: #bac2de; padding: 0 8px; }
        #workspaces button.active { color: #cba6f7; }
        #custom-weather { color: #fab387; }
        #mpris { color: #cba6f7; }
        #clock { color: #89b4fa; }
        #pulseaudio { color: #a6e3a1; }
        #network { color: #f9e2af; }
        #custom-notification { color: #f38ba8; }
      '';
    };
  };

  home-manager.users.visitante = { pkgs, ... }: {
    home.stateVersion = "25.11";
    home.enableNixpkgsReleaseCheck = false;
  };

  system.stateVersion = "25.11";
}
