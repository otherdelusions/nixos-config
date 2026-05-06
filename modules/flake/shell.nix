{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "nix-config";
        NIX_CONFIG = "extra-experimental-features = nix-command flakes";
        DIRENV_WARN_TIMEOUT = "0s";

        packages = with pkgs; [
          nil
          nixd
          nurl
          just
        ];
      };
    };
}
