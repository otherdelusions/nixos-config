{ self, ... }:
{
  flake.modules.nixos.network-hardening.imports = with self.modules.nixos; [
    zapret
    flclash
    # throne
    dnscrypt-proxy
  ];
}
