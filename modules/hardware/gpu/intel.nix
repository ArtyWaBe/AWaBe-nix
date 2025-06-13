{ config, pkgs, lib, ... }:

{
    hardware.intel-gpu-tools.enable = true;
    hardware.graphics.extraPackages = with pkgs; [
        intel-media-driver
    ];
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.boot.initrd.enable;
}