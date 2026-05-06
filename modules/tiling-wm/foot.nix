{
  flake.modules.homeManager.foot = {
    config.programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "15x15";
        };
        cursor = {
          style = "beam";
          blink = "yes";
        };
      };
    };
  };
}
