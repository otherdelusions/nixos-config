{ inputs, lib, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    treefmt.config = {
      projectRootFile = "flake.nix";
      flakeCheck = true;
      programs =
        lib.genAttrs
          [
            "nixfmt"
            "deadnix"
            "statix"
            "yamlfmt"
          ]
          (_name: {
            enable = true;
          });
    };
  };
}
