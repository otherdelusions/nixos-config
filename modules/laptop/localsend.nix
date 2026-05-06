{
  flake.modules.nixos.localsend = {
    programs.localsend.enable = true;
    environment.variables.GTK_USE_PORTAL = "1";
  };
}
