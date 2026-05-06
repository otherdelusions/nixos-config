{
  flake.modules.nixos.interloper = {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };
    users.users.root.password = "root";
  };
}
