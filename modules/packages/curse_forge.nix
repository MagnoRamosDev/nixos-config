{
  pkgs ? import <nixpkgs> { },
}:

pkgs.appimageTools.wrapType2 {
  pname = "curse-forge";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage";
    hash = "sha256-ocLq6EaM2E/yvH9zH2ESXZ8eLiquRHxStT/CDhJ2OdQ=";
  };

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    cat > $out/share/applications/curse-forge.desktop <<EOF
    [Desktop Entry]
    Name=Curse Forge
    Comment=Game Launcher
    Exec=curse-forge
    Terminal=false
    Type=Application
    Categories=Game;
    EOF
  '';
}
