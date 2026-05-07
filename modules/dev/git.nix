{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        color.ui = "auto";
        diff.algorithm = "histogram";

        pull.rebase = true;

        push = {
          default = "simple";
          autoSetupRemote = true;
        };

        rerere = {
          enabled = true;
          autoupdate = true;
        };

        merge = {
          conflictstyle = "diff3";
          stat = "true";
        };

        rebase = {
          autosquash = true;
          autostash = true;
        };

        alias = {
          l = "log --oneline --graph";
          cm = "commit -m";
          chore = "!f() { git commit -m \"chore($1): $2\"; }; f";
          docs = "!f() { git commit -m \"docs($1): $2\"; }; f";
          feat = "!f() { git commit -m \"feat($1): $2\"; }; f";
          fix = "!f() { git commit -m \"fix($1): $2\"; }; f";
          refactor = "!f() { git commit -m \"refactor($1): $2\"; }; f";
          style = "!f() { git commit -m \"style($1): $2\"; }; f";
          fmt = "!f() { git commit -m \"style($1): formatting\"; }; f";
          test = "!f() { git commit -m \"test($1): $2\"; }; f";
        };
      };

      ignores = [
        ".direnv"
        ".pre-commit-config.yaml"
      ];
    };
  };
}
