{
  flake.modules.nixos.fontspkgs =
    { pkgs, ... }:
    {
      fonts.enableDefaultPackages = true;
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        roboto
        roboto-mono
        nerd-fonts.roboto-mono
      ];
    };
}
