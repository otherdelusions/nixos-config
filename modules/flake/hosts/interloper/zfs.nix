{
  flake.modules.nixos.interloper =
    { pkgs, ... }:
    {
      boot.supportedFilesystems = [ "zfs" ];
      boot.zfs.package = pkgs.zfs_unstable;
      boot.kernelModules = [ "zfs" ];

      environment.systemPackages = with pkgs; [
        zfs_unstable
      ];
    };
}
