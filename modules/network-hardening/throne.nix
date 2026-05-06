{
  flake.modules.nixos.throne =
    { lib, config, ... }:
    {
      programs.throne = {
        enable = true;
        tunMode.enable = true;
        # tunMode.setuid = true;
      };

      networking.firewall = lib.mkIf config.networking.firewall.enable {
        trustedInterfaces = [ "throne-tun" ];
        checkReversePath = false;
      };
    };
}
