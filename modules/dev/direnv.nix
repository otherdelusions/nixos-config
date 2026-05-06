{
  flake.modules.nixos.direnv = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      settings = {
        global = {
          log_filter = "loading|using|nix-direnv|taking a while to execute";
        };
      };
    };
  };
}
