{
  flake.modules.nixos.ember =
    {
      config,
      lib,
      modulesPath,
      ...
    }:

    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "sd_mod"
      ];

      boot.kernelModules = [ "kvm-intel" ];

      boot.kernelParams = [
        "libata.force=noncq"
        "libata.noacpi=1"
      ];

      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
