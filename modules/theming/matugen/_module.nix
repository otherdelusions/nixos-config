{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.programs.matugen;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.matugen = {
    enable = lib.mkEnableOption "Material you colorscheme generator";

    templates = lib.mkOption {
      inherit (tomlFormat) type;
      default = { };
      description = "Matugen templates configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.matugen ];
    xdg.configFile."matugen/config.toml".source = tomlFormat.generate "config.toml" {
      config = { };
      inherit (cfg) templates;
    };
  };
}
