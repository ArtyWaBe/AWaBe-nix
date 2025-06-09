{ config, pkgs, lib, ... }:

{
      imports =
    [
      ./nvidia-common.nix
    ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
        powerManagement.finegrained = flase;
    };
    hardware.graphics.extraPackages = with pkgs; [
        nvidia-vaapi-driver
    ];
}