{
  pkgs ? import <nixpkgs> { },
}:

pkgs.appimageTools.wrapType2 {
  pname = "hydra-launcher";
  version = "4.0.6";

  src = pkgs.fetchurl {
    url = "https://github.com/hydralauncher/hydra/releases/download/v4.0.6/hydralauncher-4.0.6.AppImage";
    hash = "sha256-LQ2z8yUUhKLs98YvHHLnhqqtcJFGIvEQ19kB5l0Ti9E=";
  };

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
