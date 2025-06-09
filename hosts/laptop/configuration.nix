{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common/default.nix
      ../../modules/hardware/nvidia-laptop.nix
      ../../modules/hardware/intel.nix
    ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    power-profiles-daemon
  ];

  services = {
    thermald = {
      enable = true
  };
};

  hardware = {
    bluetooth = {
      enable= true;
      powerOnBoot = true;
    };

    nvidia = {
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      modesetting.enable = true;

    };
  };

}