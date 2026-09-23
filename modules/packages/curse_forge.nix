{
  pkgs ? import <nixpkgs> { },
}:

pkgs.appimageTools.wrapType2 {
  pname = "curse-forge";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage";
    hash = "sha256-4DQZNlrJGY1gGAyqB74+vhhI9lCDPAEQrayhSX5G0Uc=";
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
