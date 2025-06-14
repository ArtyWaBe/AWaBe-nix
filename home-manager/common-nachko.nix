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
	};
	};
	home.stateVersion = "25.05";
}
