{ ... }:

{
  # ==========================================
  # CONFIGURAÇÕES GLOBAIS DO GIT
  # ==========================================
  programs.git = {
    enable = true;
    userName = "MagnoRamosDev";
    userEmail = "magnoramosdeveloper@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # ==========================================
  # ROTEAMENTO SSH (Múltiplas Plataformas)
  # ==========================================
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };

      "codeberg.org" = {
        hostname = "codeberg.org";
        user = "git";
        identityFile = "~/.ssh/id_ed25519"; # Usando a mesma chave
        identitiesOnly = true;
      };
    };
  };

  services.ssh-agent.enable = true;
}
