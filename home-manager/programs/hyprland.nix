{ config, pkgs, ...}:

{
	wayland.windowManager.hyprland = {
	enable = true;
	settings = {
        general = {
            gaps_in = 5;
            gaps_out = 10;

            border_size = 3;

            # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
            col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            col.inactive_border = "rgba(595959aa)";

            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = true;

            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false;

            layout = "dwindle";
                    };
             decoration = {
                rounding = 10;
                rounding_power = 2; 

                # Change transparency of focused and unfocused windows
                active_opacity = 1.0;
                inactive_opacity = 0.9;
                };
                
                shadow = {
                    enabled = true;
                    range = 20;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };

                # https://wiki.hyprland.org/Configuring/Variables/#blur
                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    new_optimizations=true;
                    xray = true;
                    vibrancy = 0.1696;
                };
                animations = {
                    enabled = true;
                    # Animation curves
                    bezier = [
                        "linear, 0, 0, 1, 1"
                        "md3_standard, 0.2, 0, 0, 1"
                        "md3_decel, 0.05, 0.7, 0.1, 1"
                        "md3_accel, 0.3, 0, 0.8, 0.15"
                        "overshot, 0.05, 0.9, 0.1, 1.1"
                        "crazyshot, 0.1, 1.5, 0.76, 0.92 "
                        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                        "menu_decel, 0.1, 1, 0, 1"
                        "menu_accel, 0.38, 0.04, 1, 0.07"
                        "easeInOutCirc, 0.85, 0, 0.15, 1"
                        "easeOutCirc, 0, 0.55, 0.45, 1"
                        "easeOutExpo, 0.16, 1, 0.3, 1"
                        "softAcDecel, 0.26, 0.26, 0.15, 1"
                        "md2, 0.4, 0, 0.2, 1" # use with .2s duration
                    ];
                    animation = [
                        "windows, 1, 3, md3_decel, popin 60%"
                        "windowsIn, 1, 3, md3_decel, popin 60%"
                        "windowsOut, 1, 3, md3_accel, popin 60%"
                        "border, 1, 10, default"
                        "fade, 1, 3, md3_decel"
                            # animation = layers, 1, 2, md3_decel, slide
                        "layersIn, 1, 3, menu_decel, slide"
                        "layersOut, 1, 1.6, menu_accel"
                        "fadeLayersIn, 1, 2, menu_decel"
                        "fadeLayersOut, 1, 4.5, menu_accel"
                        "workspaces, 1, 7, menu_decel, slide"
                            # animation = workspaces, 1, 2.5, softAcDecel, slide
                            # animation = workspaces, 1, 7, menu_decel, slidefade 15%
                            # animation = specialWorkspace, 1, 3, md3_decel, slidefadevert 15%
                        "specialWorkspace, 1, 3, md3_decel, slidevert"
                    ];
                };
                dwindle = {
                    pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                    preserve_split = true; # You probably want this
                };

# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                master = {
                    new_status = "master";
                };

# https://wiki.hyprland.org/Configuring/Variables/#misc
                misc = {
                    force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
                    disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
                };


                #############
                ### INPUT ###
                #############

                # https://wiki.hyprland.org/Configuring/Variables/#input
                input = {
                    kb_layout = "us,bg(phonetic)";
                    kb_options = "grp:alt_shift_toggle";
                    numlock_by_default = true;

                    follow_mouse = 1;

                    sensitivity = -0.7; # -1.0 - 1.0, 0 means no modification.

                    touchpad {
                        natural_scroll = false;
                    };
                };

# https://wiki.hyprland.org/Configuring/Variables/#gestures
                gestures = {
                    workspace_swipe = true
                };

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
                device = {
                    name = "epic-mouse-v1";
                    sensitivity = -0.5;
                };           
            bind = [
                "$mainMod, C, killactive,"
                "$mainMod, M, exit,"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, L, exec, loginctl lock-session"
                "$mainMod, V, togglefloating,"
                "$mainMod, R, exec, $menu"
                "$mainMod, P, pseudo,"
                "$mainMod, J, togglesplit,"
                "$mainMod, F, fullscreen"

                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"

                # Arrange Windows
                "$mainMod SHIFT, Left, movewindow, l"
                "$mainMod SHIFT, Right, movewindow, r"
                "$mainMod SHIFT, Up, movewindow, u"
                "$mainMod SHIFT, Down, movewindow, d"


                # Switch workspaces with mainMod + [0-9]
                "$mainMod, KP_End, workspace, 1"
                "$mainMod, KP_Down, workspace, 2"
                "$mainMod, KP_Next, workspace, 3"
                "$mainMod, KP_Left, workspace, 4"
                "$mainMod, KP_Begin, workspace, 5"
                "$mainMod, KP_Right, workspace, 6"
                "$mainMod, KP_Home, workspace, 7"
                "$mainMod, KP_Up, workspace, 8"
                "$mainMod, KP_Prior, workspace, 9"
                "$mainMod, KP_Insert, workspace, 10"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, KP_End, movetoworkspace, 1"
                "$mainMod SHIFT, KP_Down, movetoworkspace, 2"
                "$mainMod SHIFT, KP_Next, movetoworkspace, 3"
                "$mainMod SHIFT, KP_Left, movetoworkspace, 4"
                "$mainMod SHIFT, KP_Begin, movetoworkspace, 5"
                "$mainMod SHIFT, KP_Right, movetoworkspace, 6"
                "$mainMod SHIFT, KP_Home, movetoworkspace, 7"
                "$mainMod SHIFT, KP_Up, movetoworkspace, 8"
                "$mainMod SHIFT, KP_Prior, movetoworkspace, 9"
                "$mainMod SHIFT, KP_Insert, movetoworkspace, 10"

                # Example special workspace (scratchpad)
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
                ];
            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];
            bindel =[
                ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"                
            ];
        };
 };    
}