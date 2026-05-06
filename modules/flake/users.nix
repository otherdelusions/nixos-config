{
  lib,
  config,
  inputs,
  ...
}:
{
  options.nixosUsers = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {

          shell = lib.mkOption {
            type = lib.types.str;
            default = "bash";
            description = "Default user shell used at system level. Must be in nixpkgs";
          };

          extraGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Extra groups to add the user to";
          };

          homeModules = lib.mkOption {
            type = lib.types.listOf lib.types.unspecified;
            default = [ ];
            description = "All home-manager modules to import for this user";
          };

        };
      }
    );

    default = { };
  };

  config = {
    # construct a nixos user module for every entry in nixosUsers
    # this **should** help with common options and reduces boilerplate
    flake.modules.nixos = lib.mapAttrs (
      name: cfg:
      { pkgs, config, ... }:
      {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];

        users.users.${name} = {
          isNormalUser = true;
          inherit (cfg) extraGroups;
          shell = pkgs.${cfg.shell};
          createHome = true;
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
          users.${name} = {
            imports = cfg.homeModules ++ [ (inputs.self.modules.homeManager.${name} or { }) ];

            home = {
              username = "${name}";
              homeDirectory = "${config.users.users.${name}.home}";
              stateVersion = "26.05";
            };
          };
        };
      }
    ) config.nixosUsers;
  };
}
