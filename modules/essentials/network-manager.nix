{
  flake.modules.nixos.network-manager =
    { lib, ... }:
    {
      networking = {
        networkmanager.enable = true;

        firewall = {
          enable = lib.mkDefault true;
          allowPing = true;
        };
      };
    };
}
