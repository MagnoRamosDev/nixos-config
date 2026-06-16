{
  pkgs ? import <nixpkgs> { },
}:

pkgs.appimageTools.wrapType2 {
  pname = "hydra-launcher";
  version = "4.0.0";

  src = /home/magno/Documentos/appimages/hydralauncher-4.0.0.AppImage;

  extraPkgs = pkgs: with pkgs; [ ];
}
