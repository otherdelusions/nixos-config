{ inputs, ... }:
{
  flake.modules.nixos.dms-greeter =
    { config, ... }:
    {
      imports = [ inputs.dms.nixosModules.greeter ];

      programs.dank-material-shell.greeter = {
        enable = true;
        logs.save = true;
        configHome = config.host-options.primaryUser.home;
      };

      # I updated this piece of shit and it started to
      # forget my username every reboot so here's
      # a temporary fix:
      #
      # sudo chown -R greeter:greeter /var/lib/dms-greeter
      # sudo chmod 750 /var/lib/dms-greeter
      # sudo systemctl restart greetd

      # systemd.services.greetd.preStart = ''
      #   cd /var/lib/dms-greeter
      #   ${config.programs.dank-material-shell.greeter.configHome}/.local/state/DankMaterialShell/session.json . || true
      #   chmod 644 memory.json || true
      #   chown greeter:greeter memory.json || true
      # '';
    };
}
