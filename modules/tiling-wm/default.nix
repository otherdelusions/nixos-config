{ self, ... }:
{
  flake.modules.nixos.tiling-wm.imports = with self.modules.nixos; [
    niri
    nautilus
    dms-greeter
  ];

  flake.modules.homeManager.tiling-wm.imports = with self.modules.homeManager; [
    niri
    nautilus
    dms-shell
    foot
    # alacritty
  ];
}
