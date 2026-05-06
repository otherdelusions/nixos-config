{
  pkgs,
  accentColor ? "",
  ...
}:

pkgs.stdenv.mkDerivation {
  pname = "adwaita-colors-morewaita";
  version = "367849d";

  src = pkgs.fetchFromGitHub {
    owner = "dpejoh";
    repo = "Adwaita-colors";
    rev = "367849dcdd269f9be17b143763eb7279087ab88c";
    hash = "sha256-R71ZRoDdlWJy+TkWkmXwyRWJTAYi4QOSmnO6GiOfGCM=";
  };

  nativeBuildInputs = with pkgs; [
    gtk3
    gnused
    adwaita-icon-theme
  ];
  propagatedBuildInputs = with pkgs; [
    morewaita-icon-theme
    adwaita-icon-theme
  ];
  dontDropIconThemeCache = true;
  dontBuild = true;

  unpackPhase = ''
    cp -r $src/. .
    chmod -R +w .
  '';

  installPhase = ''
    runHook preInstall
    export HOME=$TMPDIR/home
    mkdir -p "$HOME/.local/share/icons"

    sed -i 's|ADWAITA_PATHS=(|ADWAITA_PATHS=(\n    "${pkgs.adwaita-icon-theme}/share/icons/Adwaita"|' variants.conf

    if [ -n "${accentColor}" ]; then
      accent="${accentColor}"
      hex="''${accent#\#}"
      r=$((16#''${hex:0:2}))
      g=$((16#''${hex:2:2}))
      b=$((16#''${hex:4:2}))

      clamp() { printf '%d' $(( $1 > 255 ? 255 : ($1 < 0 ? 0 : $1) )); }

      HIGHLIGHT=$(printf '%02x%02x%02x' \
        "$(clamp $((r * 135 / 100)))" \
        "$(clamp $((g * 135 / 100)))" \
        "$(clamp $((b * 135 / 100)))")

      echo "COLOR_MAP[stylix]=\"3f8ae5:$hex 438de6:$hex 62a0ea:$hex a4caee:$HIGHLIGHT afd4ff:$HIGHLIGHT c0d5ea:$HIGHLIGHT\"" >> variants.conf
      sed -i 's/^ALL_VARIANTS=(\(.*\))/ALL_VARIANTS=(\1 stylix)/' variants.conf
      [ -d mimetypes/blue ] && cp -r mimetypes/blue mimetypes/stylix

      sed -i 's/recolor_svgs "\$variant" "\$theme_dir"/chmod -R u+w "$theme_dir"\n    recolor_svgs "$variant" "$theme_dir"/' setup
      patchShebangs setup
      ./setup -i -p "$HOME/.local/share/icons" -f stylix
      THEME_DIR="$HOME/.local/share/icons/Adwaita-stylix"
    else
      sed -i 's/recolor_svgs "\$variant" "\$theme_dir"/chmod -R u+w "$theme_dir"\n    recolor_svgs "$variant" "$theme_dir"/' setup
      patchShebangs setup
      ./setup -i -p "$HOME/.local/share/icons" -f blue
      THEME_DIR="$HOME/.local/share/icons/Adwaita-blue"
    fi

    sed -i 's/^Inherits=.*/Inherits=MoreWaita,Adwaita,AdwaitaLegacy,hicolor/' "$THEME_DIR/index.theme"
    gtk-update-icon-cache -f "$THEME_DIR"

    mkdir -p $out/share/icons
    cp -r "$HOME/.local/share/icons/Adwaita-"* $out/share/icons/
    runHook postInstall
  '';
}
