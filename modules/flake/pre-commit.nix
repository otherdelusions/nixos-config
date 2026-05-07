{ inputs, self, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      checks.pre-commit-check = inputs.git-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
        src = self;
        hooks = {
          treefmt = {
            enable = true;
            package = config.treefmt.build.wrapper;
          };

          markdownlint = {
            enable = true;
            settings.configuration = {
              MD013 = false;
              MD033 = false;
            };
          };

          convco.enable = true;
        };
      };
    };
}
