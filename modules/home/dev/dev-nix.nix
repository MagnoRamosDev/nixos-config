{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style # O formatador oficial de código Nix
  ];
}
