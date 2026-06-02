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
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
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
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "wlr";
  };

  # ==========================================
  # PROGRAMAS GLOBAIS E PACOTES
  # ==========================================
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.gamescope.enable = true;
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
      home.stateVersion = "25.11";
      home.enableNixpkgsReleaseCheck = false;

      imports = [
        ../../modules/home/wayfire.nix
        #../../modules/home/waybar.nix
        ../../modules/home/pacotes.nix

        # AMBIENTES DE DESENVOLVIMENTO
        ../../modules/home/dev/dev-vala.nix
        ../../modules/home/dev/dev-zig.nix
        ../../modules/home/dev/dev-nix.nix
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
      home.stateVersion = "25.11";
      home.enableNixpkgsReleaseCheck = false;
    };

  system.stateVersion = "25.11";
}
