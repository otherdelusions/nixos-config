{ self, ... }:
{
  imports = [
    ./_registry.nix
    ./_docs.nix
  ];

  flake.modules.nixos.homelab = {
    imports = with self.modules.nixos; [
      homelab-services
      homelab-registry
    ];
  };
}
