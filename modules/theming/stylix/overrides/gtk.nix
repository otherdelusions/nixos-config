{
  flake.modules.homeManager.stylix =
    { config, pkgs, ... }:
    let
      adwaita-colors-morewaita = pkgs.callPackage ./_adwaita-colors-morewaita.nix {
        accentColor = "${config.lib.stylix.colors.withHashtag.base0B}";
      };
    in
    {
      home.packages = [ adwaita-colors-morewaita ];
      gtk.gtk4.theme = config.gtk.theme;
    };
}
