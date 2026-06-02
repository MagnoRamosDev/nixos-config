{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Compilador e Gerenciador de Pacotes
    cargo
    rustc

    # Language Server para a IDE (Autocompletar e análise de erros em tempo real)
    rust-analyzer

    # Ferramentas de Qualidade de Código
    clippy # O linter oficial
    rustfmt # Formatador oficial de código Rust
  ];
}
