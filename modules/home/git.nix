{ ... }:

{
  # ==========================================
  # CONFIGURAÇÕES GLOBAIS DO GIT
  # ==========================================
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "MagnoRamosDev";
        email = "magnoramosdeveloper@gmail.com";
      };

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
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = true;
      };

      "codeberg.org" = {
        HostName = "codeberg.org";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = true;
      };

      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519_gitlab";
        IdentitiesOnly = true;
      };
    };
  };

  services.ssh-agent.enable = true;
}
