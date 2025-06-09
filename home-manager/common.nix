{ config, pkgs, ...}:

{
	# Example comment
	home.username = "nachko";
	home.homeDirectory = "/home/nachko";

	programs.kitty = {
		enable = true;
	};

	programs.git = {
		enable = true;
		userName = "ArtyWaBe";
    	userEmail = "hororr646@gmail.com";
    	extraConfig = {
      		init.defaultBranch = "main";
	}

	wayland.windowManager.hyprland = {
	enable = true;
	settings = {
	 "$mod" = "SUPER";
	 bind = [
	 	"$mod, Q, exec, uwsm app -- kitty"
	 	];
	 };
 };
}
