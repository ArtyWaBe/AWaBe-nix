{ config, pkgs, lib, ... }:

{
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        nvidiaSettings = true;
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
}