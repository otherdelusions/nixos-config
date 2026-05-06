{
  flake.modules.nixos.devpkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        nil
        nixd
        nurl
        go
      ];
    };
}
