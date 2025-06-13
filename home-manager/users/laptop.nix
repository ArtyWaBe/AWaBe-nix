{ config, pkgs, ...}:
{
    imports = [
        ../common.nix
        ../programs/hyprland.nix
        ../programs/uwsm.nix
    ];

    wayland.windowManager.hyprland = {
        #Setting host specific monitor settings
        monitor = [ 
            "eDP-2, 2560x1440@165.00Hz 0x0, 1"
        ];

        };
}