{ self, ... }:

{
  flake.modules.nixos.theming.imports = with self.modules.nixos; [ stylix ];

  flake.modules.homeManager.theming.imports = with self.modules.homeManager; [ stylix ];
}
