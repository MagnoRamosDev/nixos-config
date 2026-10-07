{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/home/shells/kde.nix
    inputs.openlogi.nixosModules.default
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
      "https://cosmic.cachix.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # Exceções temporárias: mantenha somente enquanto algum pacote realmente exigir.
  # openssl-1.1.1w é puxado pelo Sublime Text 4 no nixpkgs 26.05.
  # pnpm-10.29.2 deve ser removido assim que identificarmos qual pacote ainda o exige.
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "pnpm-10.29.2"
  ];

  # ==========================================
  # BOOTLOADER E KERNEL
  # ==========================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
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
  # console.keyMap = "br-abnt2";

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

  services.fstrim.enable = true;

  # ==========================================
  # INTERFACE E LOGIN
  # ==========================================
  security.polkit.enable = true;

  # ==========================================
  # SERVIÇOS DO DESKTOP
  # ==========================================
  programs.dconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  documentation.dev.enable = true;
  # Flake principal deste host.
  system.autoUpgrade = {
    enable = true;
    flake = "/home/magno/Projetos/github/nixos-config#magno-pc";
    dates = "weekly";
    randomizedDelaySec = "45min";
    allowReboot = false;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.foundryvtt = {
      # Segue atualizações da versão 14 sem avançar automaticamente para a 15.
      image = "ghcr.io/felddy/foundryvtt:14";
      ports = [ "30000:30000" ];
      volumes = [
        "/var/lib/foundryvtt:/data"
      ];
      environmentFiles = [
        "/mnt/armazenamento/FoundryVTT/foundry.env"
      ];
      extraOptions = [ "--health-start-period=60s" ];
    };
  };

  systemd.services."podman-foundryvtt" = {
    unitConfig.RequiresMountsFor = [
      "/mnt/armazenamento/FoundryVTT"
    ];

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    preStart = ''
      ${pkgs.podman}/bin/podman pull ghcr.io/felddy/foundryvtt:14 || true
    '';
  };

  # Foundry VTT publicado na rede pelo host.
  networking.firewall.allowedTCPPorts = [ 30000 ];

  # ==========================================
  # PROGRAMAS GLOBAIS E PACOTES
  # ==========================================
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.gamescope = {
    enable = true;
  };
  programs.gamemode.enable = true;
  programs.nano.enable = false;
  programs.nix-ld.enable = true;
  programs.openlogi.enable = true;

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
    # OpenGL / OpenGL ES / EGL para desenvolvimento.
    # Os drivers em si são gerenciados por hardware.graphics.
    libglvnd
    pkg-config
    glm

    # Text rendering
    freetype
    harfbuzz

    # Wayland
    wayland
    wayland-protocols
    wlroots

    # Apps
    ghostty
    micro
    git
    vesktop
    appimage-run
    brave
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
  home-manager.backupFileExtension = "backup";

  home-manager.extraSpecialArgs = { inherit inputs; };

  home-manager.users.magno =
    { pkgs, ... }:
    {
      home.stateVersion = "26.05";
      home.enableNixpkgsReleaseCheck = false;

      imports = [
        ../../modules/home/pacotes.nix
        ../../modules/home/git.nix
        # ../../modules/home/drives.nix

        # AMBIENTES DE DESENVOLVIMENTO
        ../../modules/home/dev/dev-zig.nix
        ../../modules/home/dev/dev-nix.nix
        ../../modules/home/dev/dev-rust.nix
        ../../modules/home/dev/dev-python.nix
        ../../modules/home/dev/dev-opengl.nix
      ];

      home.sessionVariables = {
        EDITOR = "subl";
        XWAYLAND_FORCE_GRAB_KEYBOARD = "1";
        NIXOS_OZONE_WL = "1";
      };

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
