{
  flake.modules.homeManager.delusion =
    { config, ... }:
    {
      sops.secrets.github_ssh_key = { };
      programs.ssh = {
        enable = true;
        matchBlocks.github = {
          host = "github.com";
          user = "git";
          identityFile = config.sops.secrets.github_ssh_key.path;
          identitiesOnly = true;
        };
      };
    };
}
