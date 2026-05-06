{ inputs, ... }:
{
  flake.modules.homeManager.dms-shell = {
    imports = [ inputs.dms.homeModules.niri ];

    programs.dank-material-shell.niri.includes = {
      enable = true;
      override = true;
      originalFileName = "niri-flake";
      filesToInclude = [
        "alttab"
        "colors"
        "layout"
      ];
    };
  };
}
