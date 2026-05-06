{
  lib,
  self,
  ...
}:
{
  options.flake.homelabServices = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          description = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
          iconUrl = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
          path = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
        };
      }
    );
    default = { };
  };

  config = {
    flake.modules.nixos.homelab-registry = {
      assertions = lib.mapAttrsToList (name: _: {
        assertion = self.homelabServices ? ${lib.removePrefix "homelab-service-" name};
        message = "${name}: missing homelabServices registry entry";
      }) (lib.filterAttrs (name: _: lib.hasPrefix "homelab-service-" name) self.modules.nixos);
    };
  };
}
