{ lib, ... }:
let
  ruLocale = "ru_RU.UTF-8";
in
{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Moscow";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = lib.genAttrs [
        "LC_NUMERIC"
        "LC_MONETARY"
        "LC_PAPER"
        "LC_MEASUREMENT"
        "LC_TELEPHONE"
      ] (_: ruLocale);
    };
  };
}
