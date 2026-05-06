{ self, ... }:
{
  flake.modules.homeManager.delusion = {
    programs.home-manager.enable = true;
    programs.niri.terminal = "foot";
    programs.helix.desktopEntry.terminal = "foot";
  };

  nixosUsers.delusion = {
    shell = "fish";

    extraGroups = [
      "networkmanager"
      "wheel"
      "greeter"
    ];

    homeModules = with self.modules.homeManager; [
      essentials
      dev
      tiling-wm
      laptop
      theming
    ];
  };
}
