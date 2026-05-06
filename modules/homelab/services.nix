{ self, ... }:

{
  flake.modules.nixos.homelab-services =
    { config, lib, ... }:
    let
      cfg = config.homelab;
      serviceModules = lib.filterAttrs (
        name: _: lib.hasPrefix "homelab-service-" name
      ) self.modules.nixos;
    in
    {
      imports = [ self.modules.nixos.homelab-base ] ++ lib.attrValues serviceModules;

      options.homelab.services.enable = lib.mkEnableOption "Enable homelab services";

      config =
        # _module.args.hlService = extraOptions: {
        #   enable = lib.mkEnableOption "Enable homelab service";
        # } // extraOptions;
        lib.mkIf (cfg.enable && cfg.services.enable) {
          systemd.services.homelab-dirs = {
            description = "Create homelab base directories";
            wantedBy = [ "multi-user.target" ];
            after = [ "local-fs.target" ];
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };
            script = ''
              set -e
              mkdir -p ${cfg.dirs.data} ${cfg.dirs.config}
              chown ${cfg.user}:${cfg.group} ${cfg.dirs.data} ${cfg.dirs.config}
              chmod 750 ${cfg.dirs.data} ${cfg.dirs.config}
            '';
          };

          systemd.targets.homelab = {
            description = "Homelab services target";
            wantedBy = [ "multi-user.target" ];
            after = [ "homelab-dirs.service" ];
          };
        };
    };
}
