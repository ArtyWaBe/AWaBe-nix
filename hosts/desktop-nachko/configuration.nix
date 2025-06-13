# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common/default.nix
      ../../modules/hardware/nvidia-desktop.nix
    ];
	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu";
				user = "greeter";
				};
			};
		};
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  	greetd.tuigreet
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
	nachko = {
		isNormalUser = true;
		description = "nachko";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
  };
};

}
