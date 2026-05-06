{
  flake.homelabServices.szurubooru = {
    description = "booru image board";
    iconUrl = "";
    path = "modules/homelab/services/szurubooru.nix";
  };

  flake.modules.nixos.homelab-service-szurubooru =
    {
      config,
      lib,
      ...
    }:

    let
      hl = config.homelab;
      cfg = hl.services.szurubooru;
    in
    {
      options.homelab.services.szurubooru = {
        enable = lib.mkEnableOption "Enable szurubooru";

        dataDir = lib.mkOption {
          type = lib.types.path;
          default = "${hl.dirs.data}/szurubooru";
          description = "Data directory for szurubooru";
        };

        port = lib.mkOption {
          type = lib.types.port;
          default = 8080;
          description = "Port to bind to";
        };

        domain = lib.mkOption {
          type = lib.types.str;
          default = "${hl.baseDomain}";
          description = "Domain for szurubooru";
        };

        database = {
          createLocally = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };

          host = lib.mkOption {
            type = lib.types.str;
            default = "localhost";
          };

          port = lib.mkOption {
            type = lib.types.port;
            default = 5432;
          };

          name = lib.mkOption {
            type = lib.types.str;
            default = "szurubooru";
          };

          user = lib.mkOption {
            type = lib.types.str;
            default = "szurubooru";
          };
        };
      };

      config = lib.mkIf (hl.enable && hl.services.enable && cfg.enable) {
        services.postgresql = lib.mkIf cfg.database.createLocally {
          enable = true;
        };

        services.szurubooru = {
          enable = true;
          inherit (hl) user group;
          inherit (cfg) dataDir;

          server = {
            host = "0.0.0.0";
            inherit (cfg) port;
            settings = {
              inherit (cfg) domain;
              tags = [ "general" ];
              categories = [ "general" ];
              ratings = [
                "safe"
                "questionable"
                "explicit"
              ];
            };
          };

          database = {
            inherit (cfg.database) host;
            inherit (cfg.database) port;
            inherit (cfg.database) name;
            inherit (cfg.database) user;
            # passwordFile = "/path/to/password"
          };

          openFirewall = true;
        };
      };
    };
}
