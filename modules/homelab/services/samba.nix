{
  flake.homelabServices.samba = {
    description = "SMB file sharing protocol";
    iconUrl = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/samba-server.png";
    path = "modules/homelab/services/samba.nix";
  };

  flake.modules.nixos.homelab-service-samba =
    { config, lib, ... }:
    let
      hl = config.homelab;
      cfg = hl.services.samba;
    in
    {
      options.homelab.services.samba = {
        enable = lib.mkEnableOption "Enable samba";

        global = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = { };
          description = "Global Samba settings";
        };

        common = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = { };
          description = "Settings applied to all shares";
        };

        shares = lib.mkOption {
          type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
          default = { };
          description = "Individual share configurations";
        };
      };

      config = lib.mkIf (hl.enable && hl.services.enable && cfg.enable) {
        networking.firewall = {
          allowedTCPPorts = [ 5357 ];
          allowedUDPPorts = [ 3702 ];
        };

        services.samba = {
          enable = true;
          openFirewall = true;

          settings = {
            global = lib.mkMerge [
              {
                workgroup = lib.mkDefault "WORKGROUP";
                "server string" = lib.mkDefault config.networking.hostName;
                "netbios name" = lib.mkDefault config.networking.hostName;
                "security" = lib.mkDefault "user";
                "invalid users" = [ "root" ];
                "guest account" = lib.mkDefault "nobody";
                "map to guest" = lib.mkDefault "bad user";
                "passdb backend" = lib.mkDefault "tdbsam";
              }
              cfg.global
            ];
          }
          // lib.mapAttrs (
            _name: value:
            lib.mkMerge [
              {
                browseable = lib.mkDefault "yes";
                "read only" = lib.mkDefault "no";
                writeable = lib.mkDefault "yes";
                "guest ok" = lib.mkDefault "no";
                "create mask" = lib.mkDefault "0644";
                "directory mask" = lib.mkDefault "0755";
              }
              cfg.common
              value
            ]
          ) cfg.shares;
        };

        services.samba-wsdd = {
          enable = true;
          discovery = true;
        };
      };
    };
}
