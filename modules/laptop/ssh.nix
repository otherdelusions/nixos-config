{
  flake.modules.homeManager.ssh = {
    programs.ssh = {
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        compression = false;
        addKeysToAgent = "yes";
        controlMaster = "no";
        controlPersist = "no";
      };
    };
  };
}
