{ config, pkgs, ...}:
{
    imports = [
        ../common.nix
        ../programs/hyprland.nix
    ];

    
    wayland.windowManager.hyprland = {
        #Setting host specific monitor settings
        monitor = [
            "DP-3, 1920x1080@144, 0x0, 1"
            "DP-2, 1920x1080@60, -1920x0, 1"
        ];
        #Setting host specific workspace settings
        workspace = [
            "1, monitor:DP-3, default:true"
            "2, monitor:DP-3"
            "3, monitor:DP-3"
            "4, monitor:DP-3"
            "5, monitor:DP-3"
            "6, monitor:DP-2, default:true"
            "7, monitor:DP-2"
            "8, monitor:DP-2"
            "9, monitor:DP-2"
            "10, monitor:DP-2"
            ];

            default_monitor = "DP-3";

        };
}