{ ... }:

{
  virtualisation.podman = {
    enable = true;

    dockerCompat = true;
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.foundryvtt = {
      image = "felddy/foundryvtt:release";
      ports = [ "30000:30000" ];
      volumes = [
        "/var/lib/foundryvtt:/data"
      ];
      environmentFiles = [
        "/mnt/armazenamento/FoundryVTT/foundry.env"
      ];
    };
  };
}
