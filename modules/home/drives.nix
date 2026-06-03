{ pkgs, ... }:

{
  systemd.user.services.rclone-gdrive = {
    description = "Montagem automatica do Google Drive via rclone";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: %h/GoogleDrive --vfs-cache-mode full";
      ExecStop = "umount %h/GoogleDrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };

  systemd.user.services.rclone-proton = {
    description = "Montagem automatica do Proton Drive via rclone";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount proton: %h/ProtonDrive --vfs-cache-mode full";
      ExecStop = "umount %h/ProtonDrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
