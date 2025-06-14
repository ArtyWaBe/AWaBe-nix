{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common/default.nix
      ../../modules/hardware/gpu/nvidia-offload.nix
      ../../modules/hardware/gpu/intel.nix
      ../../modules/hardware/perifer/bluetooth.nix
    ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    power-profiles-daemon
    greetd.tuigreet
  ];

  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiSupport = true;

  services = {
    thermald = {
      enable = true;
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

  users.users = {
	  nachko = {
      isNormalUser = true;
      description = "nachko";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
  };
};

  networking.hostName = "laptop-nachko";

  graphics.nvidiaLaptopOffload = {
    enable = true;

    iGpuType = "intel";
    #GET THIS BY RUNNING lspci -nn | grep -E 'VGA|3D|Display'
    iGpuBusId = "0000:00:02.0";
    nvidiaBusId = "0000:01:00.0";
  };

	programs.hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
			};	  
}