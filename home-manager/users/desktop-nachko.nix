{ config, pkgs, ...}:
{
    imports = [
        ../common-nachko.nix
        ../programs/hyprland.nix
        ../programs/uwsm.nix
    ];

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
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

        #Setting env variables through UWSM
        home.uwsm.env = {
            XCURSOR_SIZE = 24;
            LIBVA_DRIVER_NAME = nvidia;
            GBM_BACKEND = nvidia-drm;
            __GLX_VENDOR_LIBRARY_NAME = nvidia;
            ELECTRON_OZONE_PLATFORM_HINT = auto;
            MOZ_DISABLE_RDD_SANDBOX = 1;
            LIBVA_MESSAGING_LEVEL = 1;
            NVD_BACKEND = direct;
            };
}