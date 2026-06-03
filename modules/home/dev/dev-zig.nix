{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zig # Compilador oficial
    zls # Zig Language Server
  ];
}
