{
  flake.modules.nixos.ember =
    { pkgs, ... }:
    {
      hardware.firmware = [
        (pkgs.runCommand "hda-jack-retask-fw" { } ''
          mkdir -p $out/lib/firmware
          cp ${./hda-jack-retask.fw} $out/lib/firmware/hda-jack-retask.fw
        '')
      ];
    };
}
