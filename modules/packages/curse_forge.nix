{
  pkgs ? import <nixpkgs> { },
}:

pkgs.appimageTools.wrapType2 {
  pname = "curse-forge";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage";
    hash = "sha256-OSG5vHmY654luaHC+0gKb0Bdjxnn012z+rGqX5MX40w=";
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
