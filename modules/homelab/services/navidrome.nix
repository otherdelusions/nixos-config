{
  flake.homelabServices.navidrome = {
    description = "music streaming server";
    iconUrl = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/navidrome.png";
    path = "modules/homelab/services/navidrome.nix";
  };

  flake.modules.nixos.homelab-service-navidrome =
    {
      config,
      lib,
      ...
    }:

    let
      hl = config.homelab;
      cfg = hl.services.navidrome;
    in
    {
      options.homelab.services.navidrome = {
        enable = lib.mkEnableOption "Enable navidrome";

        configDir = lib.mkOption {
          type = lib.types.path;
          default = "${hl.dirs.config}/navidrome";
          description = "Directory for Navidrome configuration/database";
        };

        musicDir = lib.mkOption {
          type = lib.types.path;
          default = "${hl.dirs.data}/navidrome/Media/Music/Library";
          description = "Directory containing the music library";
        };

        settings = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = { };
          description = "Navidrome settings overrides";
        };
      };

      config = lib.mkIf (hl.enable && hl.services.enable && cfg.enable) {
        services.navidrome = {
          enable = true;
          openFirewall = true;
          inherit (hl) user group;

          settings = lib.mkMerge [
            {
              DataFolder = cfg.configDir;
              MusicFolder = cfg.musicDir;
              Address = "0.0.0.0";
              DefaultDownsamplingFormat = "aac";
              EnableInsightsCollector = false;
            }
            cfg.settings
          ];
        };
      };
    };
}
