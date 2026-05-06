{
  flake.modules.homeManager.helix =
    { lib, config, ... }:
    {
      options.programs.helix.desktopEntry.terminal = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "If set, creates a desktop entry to launch helix in this terminal";
      };

      config = {
        programs.helix = {
          enable = true;
          settings = {

            editor = {
              scrolloff = 18;
              line-number = "relative";
              mouse = false;
              bufferline = "multiple";
              color-modes = true;
              "cursor-shape".insert = "bar";
              completion-replace = true;
              "indent-guides" = {
                render = false;
                character = "▏";
              };
              statusline.right = [
                "diagnostics"
                "version-control"
                "position"
                "file-line-ending"
                "file-encoding"
              ];
            };

            keys.normal = {
              ret = "goto_word";
              esc = [
                "collapse_selection"
                "keep_primary_selection"
              ];
            };
          };
        };

        xdg.desktopEntries."helix-terminal" =
          lib.mkIf (config.programs.helix.desktopEntry.terminal != null)
            {
              name = "Helix (${config.programs.helix.desktopEntry.terminal} Window)";
              icon = "helix";
              exec = "${config.programs.helix.desktopEntry.terminal} -e hx %F";
              type = "Application";
              noDisplay = true;
              terminal = false;
            };

        home.sessionVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
        };
      };
    };
}
