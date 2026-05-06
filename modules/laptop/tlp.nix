{
  flake.modules.nixos.tlp = {
    services.tlp = {
      enable = true;
      pd.enable = true;
    };

    services.power-profiles-daemon.enable = false;
  };
}
