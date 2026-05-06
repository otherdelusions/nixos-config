{
  flake.modules.nixos.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
      };

      environment.systemPackages = with pkgs; [
        fish-lsp
      ];
    };

  flake.modules.homeManager.fish = {
    programs.fish = {
      enable = true;
      shellAliases = {
        ls = "ls -A --color=auto";
      };

      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };
  };
}
