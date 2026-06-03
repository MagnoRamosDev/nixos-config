{ pkgs, ... }:

{
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Montagem automatica do Google Drive via rclone";
      After = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: %h/GoogleDrive --vfs-cache-mode full";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };

  systemd.user.services.rclone-proton = {
    Unit = {
      Description = "Montagem automatica do Proton Drive via rclone";
      After = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount proton: %h/ProtonDrive --vfs-cache-mode full";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
