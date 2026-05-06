set shell := ["bash", "-uc"]

default:
    just --list

_rebuild-pre:
    git add .

[arg("action", long="boot", short="b", value="boot")]
rebuild target=shell('hostname') action='switch': _rebuild-pre
    sudo nixos-rebuild {{action}} --flake .#{{target}}

update:
    nix flake update

check:
    nix flake check

fmt:
    nix fmt .     

gc:
    sudo nix-collect-garbage -d && nix-collect-garbage -d
    @just archive

repair:
    sudo nix-store --verify --check-contents --repair

archive:
    nix flake archive .

build-iso target='interloper':
    nix build .#nixosConfigurations.{{target}}.config.system.build.isoImage

zip:
    zip -r "./$(basename "$(pwd)")".zip . -x ".direnv/*" ".git/*"
    
