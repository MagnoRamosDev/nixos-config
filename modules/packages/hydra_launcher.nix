{
  pkgs ? import <nixpkgs> { },
}:

pkgs.appimageTools.wrapType2 {
  pname = "hydra-launcher";
  version = "4.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/hydralauncher/hydra/releases/download/v4.0.0/hydralauncher-4.0.0.AppImage";
    hash = "sha256-epFymwQExsPHxAT/QOpL3cOOsbUg1WdttFQ+DKcAGRw=";
  };

  extraPkgs = pkgs: with pkgs; [ ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    cat > $out/share/applications/hydra-launcher.desktop <<EOF
    [Desktop Entry]
    Name=Hydra Launcher
    Comment=Game Launcher
    Exec=hydra-launcher
    Terminal=false
    Type=Application
    Categories=Game;
    EOF
  '';
}
