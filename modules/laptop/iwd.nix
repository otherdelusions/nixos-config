{
  flake.modules.nixos.iwd = {
    networking = {
      wireless = {
        enable = false;

        iwd = {
          enable = true;
          settings = {
            Network = {
              EnableIPv6 = false;
            };
          };
        };
      };

      networkmanager.wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
  };
}
