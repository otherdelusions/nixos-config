{
  flake.modules.homeManager.stylix =
    { config, lib, ... }:
    let
      inherit (config.lib.stylix) colors;
    in
    {
      programs.foot.settings."colors-dark".cursor = lib.mkForce "${colors.base00} ${colors.base07}";
    };
}
