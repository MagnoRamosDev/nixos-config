{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ==========================================
  # FLAKES E PERMISSÕES
  # ==========================================
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://noctalia.cachix.org"
      "https://cosmic.cachix.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

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

  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  # ==========================================
  # REDE E SISTEMA
  # ==========================================
  networking.hostName = "magno-pc";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";
  console.keyMap = "br-abnt2";

  services.gnome.gnome-keyring.enable = true;

  # ==========================================
  # ÁUDIO (PIPEWIRE) E HARDWARE
  # ==========================================
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig = {
      "52-force-software-mixer" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "node.name" = "~alsa_input.*";
              }
            ];
            actions = {
              update-props = {
                "api.alsa.soft-mixer" = true;
              };
            };
          }
        ];
      };
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  # ==========================================
  # INTERFACE E LOGIN
  # ==========================================
  security.polkit.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # ==========================================
  # SERVIÇOS DO DESKTOP
  # ==========================================
  programs.dconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.foundryvtt = {
      image = "felddy/foundryvtt:release";
      ports = [ "30000:30000" ];
      volumes = [
        "/var/lib/foundryvtt:/data"
      ];
      environmentFiles = [
        "/mnt/armazenamento/FoundryVTT/foundry.env"
      ];
    };
  };

  # ==========================================
  # PROGRAMAS GLOBAIS E PACOTES
  # ==========================================
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.gamescope = {
    enable = true;
  };
  programs.gamemode.enable = true;
  programs.nano.enable = false;
  programs.nix-ld.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.variables = {
    XKB_DEFAULT_LAYOUT = "br";
    XKB_DEFAULT_MODEL = "abnt2";
  };

  environment.pathsToLink = [
    "/share/icons"
    "/share/pixmaps"
  ];

  environment.systemPackages = with pkgs; [
    inputs.qml-language-server.packages.${pkgs.system}.default
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.qt5compat
    kdePackages.polkit-kde-agent-1
    swayosd

    nautilus
    adwaita-icon-theme
    whitesur-icon-theme
    nautilus-python

    quickshell
    fuzzel
    ghostty
    micro
    git
    wl-clipboard

    appimage-run
  ];

  # ==========================================
  # USUÁRIOS
  # ==========================================
  users.users.magno = {
    isNormalUser = true;
    description = "Magno";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
    ];
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

  home-manager.extraSpecialArgs = { inherit inputs; };

  home-manager.users.magno =
    { pkgs, ... }:
    {
      home.stateVersion = "26.05";
      home.enableNixpkgsReleaseCheck = false;

      imports = [
        ../../modules/home/pacotes.nix
        ../../modules/home/drives.nix

        # AMBIENTES DE DESENVOLVIMENTO
        ../../modules/home/dev/dev-zig.nix
        ../../modules/home/dev/dev-nix.nix
        ../../modules/home/dev/dev-rust.nix
        ../../modules/home/dev/dev-python.nix
      ];

      home.sessionVariables = {
        EDITOR = "subl";
        XWAYLAND_FORCE_GRAB_KEYBOARD = "1";
        SDL_VIDEODRIVER = "x11";
      };

      services.swayosd.enable = true;

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

      home.pointerCursor = {
        name = "breeze_cursors";
        package = pkgs.kdePackages.breeze;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

  home-manager.users.visitante =
    { ... }:
    {
      home.stateVersion = "26.05";
      home.enableNixpkgsReleaseCheck = false;
    };

  system.stateVersion = "26.05";
}
