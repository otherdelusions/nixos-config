{
  flake.modules.nixos.nautilus =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.nautilus.windowManager = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Window manager for nautilus";
      };

      config = {
        environment.systemPackages = [ pkgs.nautilus ];
        services.gvfs.enable = true;

        xdg.portal = lib.mkIf (config.programs.nautilus.windowManager != null) {
          enable = true;
          config.${config.programs.nautilus.windowManager} = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.Access" = "gtk";
            "org.freedesktop.impl.portal.FileChooser" = "gnome";
            "org.freedesktop.impl.portal.Notification" = "gtk";
            "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          };
          extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        };

        programs.nautilus-open-any-terminal = {
          enable = true;
        };
      };
    };

  flake.modules.homeManager.nautilus =
    { config, ... }:
    {
      xdg.userDirs.enable = true;
      xdg.userDirs.setSessionVariables = true;

      home.file =
        let
          inherit (config.xdg.userDirs) templates;
        in
        {
          "${templates}/Empty Text.txt".text = "";
        };
    };
}
