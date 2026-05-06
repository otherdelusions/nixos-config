{
  flake.modules.homeManager.niri = {
    programs.niri.settings.environment = {
      QT_QPA_PLATFORM = "wayland";
      WINIT_UNIX_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      GTK_USE_PORTAL = "1";
    };
  };
}
