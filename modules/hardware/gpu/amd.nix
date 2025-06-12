{ config, pkgs, lib, ... }:

{
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.boot.initrd.enable;
}