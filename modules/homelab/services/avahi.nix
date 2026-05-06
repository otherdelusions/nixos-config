{
  flake.homelabServices.avahi = {
    description = "zeroconf and mDNS";
    iconUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Avahi-logo.svg/330px-Avahi-logo.svg.png";
    path = "modules/homelab/services/avahi.nix";
  };

  flake.modules.nixos.homelab-service-avahi =
    {
      config,
      lib,
      ...
    }:

    let
      hl = config.homelab;
      cfg = hl.services.avahi;
    in
    {
      options.homelab.services.avahi.enable = lib.mkEnableOption "Enable avahi";

      config = lib.mkIf (hl.enable && hl.services.enable && cfg.enable) {
        services.avahi = {
          enable = true;
          openFirewall = true;
          nssmdns4 = true;

          publish = {
            enable = true;
            userServices = true;
            workstation = true;
            domain = true;
          };
        };
      };
    };
}
