{ inputs, self, ... }:
{
  flake.modules.homeManager.stylix =
    { lib, config, ... }:
    {
      stylix.enable = true;

      stylix.icons = {
        enable = true;
        dark = "Adwaita-stylix";
        light = "Adwaita-stylix";
      };

      stylix.targets.librewolf = lib.mkIf config.programs.librewolf.enable {
        colorTheme.enable = true;
        profileNames = [ "default" ];
      };
    };

  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix =
        let
          apple-fonts = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system};
          image = "${self}/config/wallpaper/qingyi.jpg";
        in
        {
          enable = true;
          autoEnable = true;

          inherit image;
          polarity = "dark";

          base16Scheme = {
            base00 = "151616";
            base01 = "192121";
            base02 = "343636";
            base03 = "424c4c";
            base04 = "d7dede";
            base05 = "efefef";
            base06 = "fefeff";
            base07 = "fefeff";
            base08 = "ea6637";
            base09 = "f7961a";
            base0A = "fbb627";
            base0B = "1ccbaf";
            base0C = "18cdc4";
            base0D = "11c9de";
            base0E = "f184d6";
            base0F = "61ccb6";
          };

          fonts = {
            monospace = {
              package = apple-fonts.sf-mono-nerd;
              name = "SFMono Nerd Font";
            };
            sansSerif = {
              package = apple-fonts.sf-pro-nerd;
              name = "SFProDisplay Nerd Font";
            };
            serif = {
              package = apple-fonts.ny-nerd;
              name = "New York Nerd Font";
            };
          };
        };
    };
}
