{
  flake.modules.homeManager.alacritty = {
    config.programs.alacritty = {
      enable = true;

      settings = {
        debug.renderer = "glsl3";
        window = {
          padding = {
            x = 15;
            y = 15;
          };
        };

        env.TERM = "alacritty";

        cursor = {
          style.shape = "Beam";
          style.blinking = "Off";
          vi_mode_style.shape = "Beam";
          unfocused_hollow = false;
          blink_timeout = 0;
        };
      };
    };
  };
}
