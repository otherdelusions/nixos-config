{ inputs, ... }:

let
  defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
  defaultSopsFormat = "yaml";
in
{
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = with pkgs; [
        sops
        age
        ssh-to-age
      ];

      services.openssh.hostKeys = [
        {
          type = "ed25519";
          path = "/etc/ssh/ssh_host_ed25519_key";
        }
      ];

      # REMINDER:
      # To manually generate standalone (user) key:
      #   mkdir -p ~/.config/sops/age
      #   age-keygen -o ~/.config/sops/age/keys.txt
      #   *copy pubkey to .sops.yaml under "users"*
      #   sops updatekeys secrets/secrets.yaml
      #
      # To manually generate host key:
      #   cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
      #   *copy pubkey to .sops.yaml under "hosts"*
      #   sops updatekeys secrets/secrets.yaml
      #
      # Corresponding private keys
      # (keys.txt for standalone and ssh_host_ed25519_key for host)
      # must be backed up in a secure vault, losing these means
      # losing the access to secrets.yaml file(s) and underlying
      # secrets

      sops = {
        inherit defaultSopsFile defaultSopsFormat;
        age = {
          sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # from which key to generate private age
          keyFile = "/var/lib/sops-nix/key.txt"; # where to store private age
          generateKey = true; # age-keygen -y /var/lib/sops-nix/key.txt to extract pubkey
        };

      };
    };

  flake.modules.homeManager.sops =
    { config, ... }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        inherit defaultSopsFile defaultSopsFormat;
        age = {
          keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
          generateKey = true; # age-keygen -y ~/.config/sops/age/keys.txt to extract pubkey
        };
      };
    };
}
