{
  flake.modules.nixos.flclash =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        flclash
      ];
    };
}
