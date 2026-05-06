{ self, ... }:
{
  flake.modules.nixos.graphical.imports = with self.modules.nixos; [
    grub
    pipewire
    graphics
    graphicalpkgs
    fontspkgs
  ];
}
