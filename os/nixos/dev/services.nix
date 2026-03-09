{ pkgs, ... }:
{
systemd.services.jobs = {
    description = "Jobs app";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    environment = {
      DB_PATH = "/home/will/code/jobs/jobs.sqlite3";
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
    serviceConfig = {
      Type = "simple";
      User = "will";
      WorkingDirectory = "/home/will/code/jobs";
      ExecStart = "${pkgs.litestream}/bin/litestream replicate -exec '/home/will/code/jobs/.venv/bin/jobs' -config /home/will/code/jobs/litestream.yml";
      Restart = "on-failure";
      RestartSec = 5;
      ReadWritePaths = [ "/home/will/code/jobs" ];
      StateDirectory = "jobs";
      EnvironmentFile = "/home/will/code/jobs/.env";
    };
  };

  systemd.services.network-index = {
    description = "Network Index app";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "will";
      WorkingDirectory = "/home/will/code/network-index";
      ExecStart = "${pkgs.zola}/bin/zola serve --interface 0.0.0.0 --port 80";
      AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      Restart = "on-failure";
      RestartSec = 5;
      ReadWritePaths = [ "/home/will/code/network-index" ];
    };
  };
}
