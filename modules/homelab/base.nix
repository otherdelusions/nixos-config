_:

{
  flake.modules.nixos.homelab-base =
    { lib, config, ... }:

    let
      cfg = config.homelab;
    in
    {
      options.homelab = {
        enable = lib.mkEnableOption "Enable homelab";

        dirs = {
          data = lib.mkOption {
            type = lib.types.path;
            default = "/var/lib/homelab";
            description = "Directory for homelab service data";
          };

          config = lib.mkOption {
            type = lib.types.path;
            default = "/etc/homelab";
            description = "Directory for homelab service configuration files";
          };
        };

        user = lib.mkOption {
          default = "homelab";
          type = lib.types.str;
          description = "User to run homelab as";
        };

        group = lib.mkOption {
          default = "homelab";
          type = lib.types.str;
          description = "Group to run homelab as";
        };

        timeZone = lib.mkOption {
          default = config.time.timeZone;
          type = lib.types.nullOr lib.types.str;
          description = "Timezone used across the homelab";
        };

        baseDomain = lib.mkOption {
          default = "";
          type = lib.types.str;
          description = "Base domain used across the homelab";
        };
      };

      config = lib.mkIf cfg.enable {
        users = {
          groups.${cfg.group} = { };
          users.${cfg.user} = {
            isSystemUser = true;
            inherit (cfg) group;
            description = "Homelab services user";
          };
        };
      };
    };
}
