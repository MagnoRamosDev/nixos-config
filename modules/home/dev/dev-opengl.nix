{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Compilador C/C++
    gcc

    # Ferramentas Clang sem conflito com gcc
    clang-tools

    # Build
    cmake
    meson
    ninja
    pkg-config

    # OpenGL ES / EGL
    libglvnd
    libglvnd.dev

    # Matemática para gráficos
    glm

    # Testes OpenGL / EGL / GLES
    mesa-demos

    # Debug
    gdb

    # Opcional para janela/contexto:
    # glfw
    # SDL2
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.libglvnd.dev}/lib/pkgconfig";
    C_INCLUDE_PATH = "${pkgs.libglvnd.dev}/include";
    CPLUS_INCLUDE_PATH = "${pkgs.libglvnd.dev}/include";
    LIBRARY_PATH = "${pkgs.libglvnd}/lib";
  };
}
