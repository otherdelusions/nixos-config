{
  flake.modules.nixos.zapret = {
    imports = [ ./_module.nix ];

    custom.zapret = {
      enable = true;
      addHosts = true;
      strategy = "flow_alt9_nogen";
    };
  };
}
