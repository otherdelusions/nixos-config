{
  lib,
  inputs,
  config,
  ...
}:
{
  options.nixosHosts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {

          system = lib.mkOption {
            type = lib.types.str;
            default = "x86_64-linux";
            description = "Host's system architecture";
          };

          primaryUser = {
            name = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "System's primary user name. Must be one of existing users on the host";
            };
          };

          modules = lib.mkOption {
            type = lib.types.listOf lib.types.unspecified;
            default = [ ];
            description = "Nixos level modules for this host";
          };

        };
      }
    );

    default = { };
  };

  config = {
    flake.nixosConfigurations = lib.mapAttrs (
      name: cfg:
      inputs.nixpkgs.lib.nixosSystem {
        inherit (cfg) system;
        specialArgs = { inherit inputs; };

        modules = [
          (inputs.self.modules.nixos.${name} or { })
          {
            networking.hostName = "${name}";
            networking.hostId = builtins.substring 0 8 (builtins.hashString "sha256" name);
            nixpkgs.hostPlatform = lib.mkDefault "${cfg.system}";
          }

          inputs.self.modules.nixos.host-options
          { host-options = { inherit (cfg) primaryUser; }; }
        ]
        ++ cfg.modules;
      }
    ) config.nixosHosts;
  };
}
