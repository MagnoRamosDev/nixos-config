{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # O Compilador C
    gcc

    # Compilador e Ferramentas
    vala
    meson
    ninja
    pkg-config

    # Bibliotecas essenciais para o Astal/GTK
    glib
    gtk4
    gobject-introspection

    # Language Server para a IDE
    vala-language-server
  ];
}
