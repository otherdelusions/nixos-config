{ self, ... }:
{
  flake.modules.nixos.essentials.imports = with self.modules.nixos; [
    nix
    sops
    locale
    network-manager
  ];

  flake.modules.homeManager.essentials.imports = with self.modules.homeManager; [
    sops
  ];
}
