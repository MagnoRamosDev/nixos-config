{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    virtualenv
    pyright
    # python3Packages.python-lsp-server # Outra alternativa popular, caso não goste do pyright
    ruff
    # black # Descomente se preferir usar o formatador padrão clássico da comunidade
  ];
}
