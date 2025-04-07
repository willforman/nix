let
  users = {
      mbp = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEd+kmG9ScsNZZtqNRnhsBIBBSM5sv/ma8cuHTjGU6UQ wf8581@gmail.com";
      mbp2025 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4rvLHPVeJWl8WHQimBAAIv8fPykLhUphwbwH+fk/oG";
      desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3E5qb0rP7crUGLtOoztcPvXZ42P8QQMNXZrNXDxWKi wf8581@gmail.com";
      dev = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSSsTq5FjE5T6k0XYjulF89EHiYl4XRt9sMuIE7ah0N wf8581@gmail.com";
  };
  allUsers = builtins.attrValues users;
in {
  "anthropic-api-key.age".publicKeys = allUsers;
  "remote-dev-ip.age".publicKeys = allUsers;
}
