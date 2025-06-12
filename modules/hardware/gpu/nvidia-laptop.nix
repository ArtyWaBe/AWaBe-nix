{ config, pkgs, lib, ... }:

let
    cfg = config.graphics.nvidiaLaptopOffload;

  # This is a helper function to convert "00:02.0" PCI ID format
  # (which `lspci` gives you) into the "PCI:0:2:0" format that the NVIDIA driver options need
    formatBusId = id:
    let
        parts = lib.splitString ":" id;
        
        domain = if (lib.length parts) == 3 && (lib.stringLength (lib.head parts)) > 2
               then "PCI:${builtins.fromDigits (lib.stringToCharacters (lib.substring 0 2 (lib.head parts)))}@"
               else "";
               # Extracts the bus, device, and function numbers
               bus = builtins.fromDigits (lib.stringToCharacters (lib.elemAt parts (lib.length parts - 3)));
               device = builtins.fromDigits (lib.stringToCharacters (lib.elemAt parts (lib.length parts - 2)));
               function = builtins.fromDigits (lib.stringToCharacters (lib.elemAt parts (lib.length parts - 1)));
        in "${domain}${bus}:${device}:${function}";

in {
      imports =
    [
      ./nvidia-common.nix
    ];
    options.graphics.nvidiaLaptopOffload = {
    # If this is 'false', the 'config' block below won't be applied.
        enable = lib.mkEnableOption "NVIDIA GPU support on Optimus laptops (Prime Offload)";

        intelBusId = lib.mkOption {
        type = lib.types.str;
        description = "PCI Bus ID of the Intel iGPU (e.g., '00:02.0').";
        };
        nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        description = "PCI Bus ID of the NVIDIA dGPU (e.g., '01:00.0').";
        };
    };
    #Ensures settings are applied if the enable option is true
    config = lib.mkIf cfg.enable {
        _module.check = {
        assertion = cfg.intelBusId != "" && cfg.nvidiaBusId != "";
        message = "NVIDIA Prime Offload requires 'intelBusId' and 'nvidiaBusId' to be set in graphics.nvidiaLaptopOffload.";
    };
    services.xserver.videoDrivers = [ "modesetting" "nvidia" ]; #modesetting is Intel, use amdgpu for amd, setting the order of driver search

    hardware.nvidia.powerManagement.finegrained = true;

    hardware.nvidia.prime ={
        intelBusId = formatBusId cfg.intelBusId;
        nvidiaBusId = formatBusId cfg.nvidiaBusId;

        offload.enable = true;
        offload.enableOffloadCmd = true; #creates the nvidia-offload command to run programs with gpu accel (basically prime-run)
        sync.enable = false;
    }
    }

}