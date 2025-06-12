{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common/default.nix
      ../../modules/hardware/gpu/nvidia-laptop.nix
      ../../modules/hardware/gpu/intel.nix
      ../../modules/hardware/perifer/bluetooth.nix
    ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    power-profiles-daemon
    greetd.tuigreet
  ];

  services = {
    thermald = {
      enable = true
  };
  	greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu";
				user = "greeter";
				};
			};
		};
};
		
  programs.hyprland = {
		enable = true;
		withUWSM = true;
		xwayland.enable = true;
		};

  users.users = {
	  nachko = {
      isNormalUser = true;
      description = "nachko";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
  };
};
}