{
  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "nixos-config";
        inherit (config.checks.pre-commit-check) shellHook;
        NIX_CONFIG = "extra-experimental-features = nix-command flakes";
        DIRENV_WARN_TIMEOUT = "0s";

        packages = with pkgs; [
          nil
          nixd
          nurl
          just
          nix-prefetch-github
        ];
      };
    };
}
