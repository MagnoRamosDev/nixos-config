{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    clang-tools

    cmake
    meson
    ninja
    pkg-config

    libglvnd
    libglvnd.dev

    glm
    mesa-demos
    gdb
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -gx PKG_CONFIG_PATH "${pkgs.libglvnd.dev}/lib/pkgconfig"
      set -gx C_INCLUDE_PATH "${pkgs.libglvnd.dev}/include"
      set -gx CPLUS_INCLUDE_PATH "${pkgs.libglvnd.dev}/include"
      set -gx LIBRARY_PATH "${pkgs.libglvnd}/lib"
    '';
  };
}
