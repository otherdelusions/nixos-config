{ self, ... }:

{
  flake.modules.nixos.ember = {
    documentation.man.cache.enable = false;
    system.stateVersion = "26.05";

    systemd.user.services.niri-flake-polkit.enable = false;
    programs.nautilus.windowManager = "niri";
    programs.nautilus-open-any-terminal.terminal = "foot";
    programs.dank-material-shell.greeter.compositor.name = "niri";
  };

  nixosHosts.ember = {
    system = "x86_64-linux";
    primaryUser.name = "delusion";
    modules = with self.modules.nixos; [
      essentials
      dev
      graphical
      tiling-wm
      laptop
      network-hardening
      theming

      delusion
    ];
  };
}
