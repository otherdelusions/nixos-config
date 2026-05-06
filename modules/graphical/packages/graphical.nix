{
  flake.modules.nixos.graphicalpkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wl-clipboard
        morewaita-icon-theme
        adw-gtk3
        loupe
        papers
        ripunzip
        zip
        tealdeer
        ffmpegthumbnailer
        (mpv.override {
          scripts = [
            mpvScripts.thumbfast
          ];
        })
      ];
    };
}
