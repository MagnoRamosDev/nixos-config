{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd               # Nix Language Server atual
    nixfmt-rfc-style   # O formatador oficial de código Nix
  ];
}
