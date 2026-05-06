{ self, ... }:
{
  flake.modules.nixos.dev.imports = with self.modules.nixos; [
    devpkgs
    direnv
    fish
  ];

  flake.modules.homeManager.dev.imports = with self.modules.homeManager; [
    git
    helix
    fastfetch
    starship
    fish
  ];
}
