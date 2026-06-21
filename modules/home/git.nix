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

    includes = [
      {
        condition = "gitdir:~/Projetos/gitlab/";
        contents = {
          user.email = "magnoramosdeveloper+gitlab@gmail.com";
        };
      }
    ];
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
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_gitlab";
        identitiesOnly = true;
      };
    };
  };

  services.ssh-agent.enable = true;
}
