{
  flake.modules.nixos.grub = {
    boot.loader = {
      grub = {
        enable = true;
        efiSupport = true;
        configurationLimit = 5;
        device = "nodev";
        timeoutStyle = "hidden";
      };

      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
  };
}
