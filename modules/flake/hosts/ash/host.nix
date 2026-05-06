{ self, ... }:

{
  flake.modules.nixos.ash = {
    documentation.man.cache.enable = false;
    system.stateVersion = "26.05";
  };

  nixosHosts.ash = {
    system = "x86_64-linux";
    modules = with self.modules.nixos; [
      essentials
      homelab
    ];
  };
}
