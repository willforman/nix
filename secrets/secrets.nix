let
  users = {
      mbp = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINT6g7uwS7pKQ1XKmfGCuwb2RUgHOYKYWCV7fKrh34X6 wf@willforman.com";
      desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3E5qb0rP7crUGLtOoztcPvXZ42P8QQMNXZrNXDxWKi wf8581@gmail.com";
      dev = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSSsTq5FjE5T6k0XYjulF89EHiYl4XRt9sMuIE7ah0N wf8581@gmail.com";
  };
  allUsers = builtins.attrValues users;
in {
  "remote-dev-ip.age".publicKeys = allUsers;
}
