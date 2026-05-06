{ self, ... }:

{
  flake.modules.nixos.interloper = {
    networking.firewall.enable = false;
    system.stateVersion = "26.05";
  };

  nixosHosts.interloper = {
    system = "x86_64-linux";
    modules = with self.modules.nixos; [
      essentials
    ];
  };
}
