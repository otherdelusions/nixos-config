{ lib, ... }:
{
  flake.modules.nixos.host-options =
    { config, ... }:
    {
      options.host-options = {
        primaryUser = {
          name = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };

          home = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default =
              if config.host-options.primaryUser.name != null then
                config.users.users.${config.host-options.primaryUser.name}.home
              else
                null;
            readOnly = true;
          };
        };
      };

      config = lib.mkIf (config.host-options.primaryUser.name != null) {
        assertions =
          let
            normalUsers = lib.attrNames (lib.filterAttrs (_: u: u.isNormalUser or false) config.users.users);
          in
          [
            {
              assertion = builtins.elem config.host-options.primaryUser.name normalUsers;
              message = ''
                Primary user '${config.host-options.primaryUser.name}' does not exist.
                Available users: ${toString normalUsers}
              '';
            }
          ];
      };
    };
}
