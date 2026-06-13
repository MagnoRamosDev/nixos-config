{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.foundryvtt = {
      image = "felddy/foundryvtt:release";
      ports = [ "30000:30000" ];
      volumes = [
        "/var/lib/foundryvtt:/data"
      ];
      environmentFiles = [
        "/var/secrets/foundry.env"
      ];
    };
  };
}
