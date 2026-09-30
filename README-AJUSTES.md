# Configuração NixOS ajustada

Esta pasta preserva a estrutura dos arquivos enviados e aplica correções conservadoras.

## Alterações principais

- remove o input `qml-language-server`, que não estava sendo usado;
- importa `git.nix` no Home Manager;
- instala `cliphist` e corrige o autostart dele no Wayfire;
- deixa de forçar `SDL_VIDEODRIVER=x11` globalmente;
- separa a preferência de XDG portals para Hyprland e Wayfire;
- corrige a versão declarada do Proton Drive CLI para `0.6.0`;
- remove `mesa`, `mesa.drivers` e `libGL` de `environment.systemPackages` porque os drivers são gerenciados por `hardware.graphics`;
- adiciona limite de gerações do systemd-boot, TRIM, GC e otimização periódica do Nix;
- configura o auto-upgrade para o flake `magno-pc`;
- faz o serviço do Foundry depender explicitamente do disco em `/mnt/armazenamento`;
- usa `ghcr.io/felddy/foundryvtt:14`, acompanhando atualizações da versão 14 sem pular automaticamente para uma nova major;
- abre TCP/30000 no firewall para o Foundry.

## Caminho do flake

Confirmado pelo usuário:

```nix
system.autoUpgrade.flake = "/home/magno/Projetos/github/nixos-config#magno-pc";
```

## Exceções inseguras ainda preservadas

As permissões para:

- `openssl-1.1.1w`
- `pnpm-10.29.2`

foram mantidas para não quebrar a avaliação antes de sabermos exatamente quais pacotes dependem delas.

O `openssl-1.1.1w` está associado ao `sublime4` no nixpkgs 26.05.
O `pnpm-10.29.2` precisa ser rastreado no closure real da sua máquina.

## Validação recomendada

Na raiz do flake:

```bash
nix flake check
sudo nixos-rebuild build --flake .#magno-pc
```

Se o build passar:

```bash
sudo nixos-rebuild switch --flake .#magno-pc
```

Para confirmar a raiz do repositório:

```bash
pwd
```

Se houver erro relacionado a pacote inseguro, envie a mensagem completa; com ela dá para localizar a dependência sem remover aplicações às cegas.
