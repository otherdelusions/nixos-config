{
  flake.modules.homeManager.niri =
    { config, lib, ... }:
    {
      options.programs.niri = {
        terminal = lib.mkOption {
          type = lib.types.str;
          default = null;
          description = "Default terminal used in binds";
        };

        backlightDevice = lib.mkOption {
          type = lib.types.str;
          default = "backlight:intel_backlight";
          description = "Backlight device used in binds";
        };
      };

      config.programs.niri.settings.binds =
        let
          cfg = config.programs.niri;

          dmsIpc = [
            "dms"
            "ipc"
            "call"
          ];
        in
        {
          "Super+R".action.spawn = dmsIpc ++ [
            "spotlight"
            "toggle"
          ];
          "Super+P".action.spawn = dmsIpc ++ [
            "powermenu"
            "toggle"
          ];
          "XF86AudioRaiseVolume".action.spawn = dmsIpc ++ [
            "audio"
            "increment"
            "5%"
          ];
          "XF86AudioLowerVolume".action.spawn = dmsIpc ++ [
            "audio"
            "decrement"
            "5%"
          ];
          "XF86MonBrightnessUp".action.spawn = dmsIpc ++ [
            "brightness"
            "increment"
            "5%"
            cfg.backlightDevice
          ];
          "XF86MonBrightnessDown".action.spawn = dmsIpc ++ [
            "brightness"
            "decrement"
            "5%"
            cfg.backlightDevice
          ];
          "XF86AudioMute".action.spawn = dmsIpc ++ [
            "audio"
            "mute"
          ];
          "XF86AudioMicMute".action.spawn = dmsIpc ++ [
            "audio"
            "micmute"
          ];
          "XF86Tools".action.spawn = dmsIpc ++ [
            "settings"
            "focusOrToggle"
          ];
          "XF86Display".action.spawn = dmsIpc ++ [
            "inhibit"
            "toggle"
          ];
          "Super+L".action.spawn = dmsIpc ++ [
            "lock"
            "lock"
          ];

          "Super+Left".action.focus-column-left = [ ];
          "Super+Down".action.focus-window-down = [ ];
          "Super+Up".action.focus-window-up = [ ];
          "Super+Right".action.focus-column-right = [ ];
          "Super+Ctrl+Left".action.move-column-left = [ ];
          "Super+Ctrl+Down".action.move-window-down = [ ];
          "Super+Ctrl+Up".action.move-window-up = [ ];
          "Super+Ctrl+Right".action.move-column-right = [ ];

          "Super+Home".action.focus-column-first = [ ];
          "Super+End".action.focus-column-last = [ ];
          "Super+Ctrl+Home".action.move-column-to-first = [ ];
          "Super+Ctrl+End".action.move-column-to-last = [ ];

          "Super+Page_Down".action.focus-workspace-down = [ ];
          "Super+Page_Up".action.focus-workspace-up = [ ];
          "Super+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
          "Super+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];
          "Super+Shift+Page_Down".action.move-workspace-down = [ ];
          "Super+Shift+Page_Up".action.move-workspace-up = [ ];

          "Super+1".action.focus-workspace = 1;
          "Super+2".action.focus-workspace = 2;
          "Super+3".action.focus-workspace = 3;
          "Super+4".action.focus-workspace = 4;
          "Super+5".action.focus-workspace = 5;
          "Super+6".action.focus-workspace = 6;
          "Super+7".action.focus-workspace = 7;
          "Super+8".action.focus-workspace = 8;
          "Super+9".action.focus-workspace = 9;

          "Super+Control+1".action.move-column-to-workspace = 1;
          "Super+Control+2".action.move-column-to-workspace = 2;
          "Super+Control+3".action.move-column-to-workspace = 3;
          "Super+Control+4".action.move-column-to-workspace = 4;
          "Super+Control+5".action.move-column-to-workspace = 5;
          "Super+Control+6".action.move-column-to-workspace = 6;
          "Super+Control+7".action.move-column-to-workspace = 7;
          "Super+Control+8".action.move-column-to-workspace = 8;
          "Super+Control+9".action.move-column-to-workspace = 9;

          "Super+BracketLeft".action.consume-or-expel-window-left = [ ];
          "Super+BracketRight".action.consume-or-expel-window-right = [ ];
          "Super+Comma".action.consume-window-into-column = [ ];
          "Super+Period".action.expel-window-from-column = [ ];

          "Super+T".action.switch-preset-column-width = [ ];
          "Super+Shift+T".action.switch-preset-window-height = [ ];
          "Super+Ctrl+T".action.reset-window-height = [ ];
          "Super+F".action.maximize-column = [ ];
          "Super+Shift+F".action.fullscreen-window = [ ];
          "Super+Ctrl+F".action.expand-column-to-available-width = [ ];

          "Super+Minus".action.set-column-width = "-10%";
          "Super+Equal".action.set-column-width = "+10%";
          "Super+Shift+Minus".action.set-window-height = "-10%";
          "Super+Shift+Equal".action.set-window-height = "+10%";

          "Print".action.screenshot = {
            show-pointer = false;
          };
          "Ctrl+Print".action.screenshot-screen = {
            show-pointer = false;
          };
          "Alt+Print".action.screenshot-window = {
            show-pointer = false;
          };

          "Super+W".action.toggle-column-tabbed-display = [ ];
          "Super+V".action.toggle-window-floating = [ ];
          "Super+D".action.center-column = [ ];
          "Super+C".action.close-window = [ ];

          "Ctrl+Alt+Delete".action.quit = [ ];

          "Mod+Tab".action.toggle-overview = [ ];

          "Super+Q".action.spawn = cfg.terminal;
        };
    };
}
