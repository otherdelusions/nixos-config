{
  flake.modules.homeManager.matugen = {
    imports = [ ./_module.nix ];

    programs.matugen.enable = true;
  };
}
