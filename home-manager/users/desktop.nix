{ config, pkgs, ...}:
{
    imports = [
        ../common.nix
        ../programs/hyprland.nix
    ];
}