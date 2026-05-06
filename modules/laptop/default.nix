{ self, ... }:
{
  flake.modules.nixos.laptop.imports = with self.modules.nixos; [
    librewolf
    localsend
    tlp
    upower
    iwd
  ];

  flake.modules.homeManager.laptop.imports = with self.modules.homeManager; [
    librewolf
    ssh
  ];
}
