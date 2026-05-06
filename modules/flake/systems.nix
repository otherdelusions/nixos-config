{ lib, ... }:
{
  systems = lib.filter (s: s != "x86_64-darwin") lib.systems.flakeExposed;
}
