{ pkgs, ... }:
{
systemd.services.jobs = {
    description = "Jobs app";
    after = [ "network.target" ];
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
}
