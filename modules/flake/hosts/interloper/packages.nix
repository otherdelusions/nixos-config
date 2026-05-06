{
  flake.modules.nixos.interloper =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        disko
        git
        helix
        nurl
        nixd
        nil
        wget
        curl
        smartmontools
        unzip
        zip
        nixfmt
      ];
    };
}
