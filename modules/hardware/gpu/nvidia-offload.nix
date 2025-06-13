{ config, pkgs, lib, ... }:

let
    cfg = config.graphics.nvidiaLaptopOffload;

# This is a helper function to convert "00:02.0" PCI ID format
# (which `lspci` gives you) into the "PCI:0:2:0" format that the NVIDIA driver options need
    formatBusId = id:
      let
        # Split by ':' to separate potential domain from the rest, and then bus from device.function
        # Example: "00:02.0" -> [ "00", "02.0" ]
        # Example: "0000:01:00.0" -> [ "0000", "01", "00.0" ]
        parts = lib.splitString ":" id;

        # Determine Domain (D)
        # If the original ID has 3 parts (e.g., "0000:01:00.0"), the first part is the domain.
        # Otherwise, the domain is implicitly 0.
        rawDomain = if (lib.length parts) == 3 then lib.elemAt parts 0 else "0000"; # Use "0000" as a placeholder for domain 0
        # Convert domain hex string to decimal and format for output
        domainStr = "PCI:${builtins.fromDigits (lib.stringToCharacters rawDomain)}:";

        # Determine Bus (B)
        # If domain was present, bus is the second element. Else, it's the first.
        rawBus = if (lib.length parts) == 3 then lib.elemAt parts 1 else lib.elemAt parts 0;
        # Convert bus hex string to decimal
        busNum = builtins.fromDigits (lib.stringToCharacters rawBus);

        # Determine Device (D) and Function (F)
        # This is always the last part (e.g., "00.0" or "02.0")
        deviceFuncStr = lib.elemAt parts (lib.length parts - 1);
        # Now split this part by the dot '.'
        deviceFuncParts = lib.splitString "." deviceFuncStr;

        # Extract raw device and function strings
        rawDevice = lib.elemAt deviceFuncParts 0;
        rawFunction = lib.elemAt deviceFuncParts 1;

        # Convert device and function hex strings to decimal
        deviceNum = builtins.fromDigits (lib.stringToCharacters rawDevice);
        functionNum = builtins.fromDigits (lib.stringToCharacters rawFunction);

      in "${domainStr}${toString busNum}:${toString deviceNum}:${toString functionNum}";

in {
      imports =
    [
      ./nvidia-common.nix
    ];
    options.graphics.nvidiaLaptopOffload = {
    # If this is 'false', the 'config' block below won't be applied.
        enable = lib.mkEnableOption "NVIDIA GPU support on Optimus laptops (Prime Offload)";

        iGpuType = lib.mkOption {
          type = lib.types.enum [ "intel" "amd" ];
          description = "Type of the integrated GPU.";
          default = "intel";
        };
        iGpuBusId = lib.mkOption {
          type = lib.types.str;
          description = "PCI Bus ID of the Integrated GPU (e.g., '00:02.0' for Intel, '00:01.0' for AMD).";
        };
        nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        description = "PCI Bus ID of the NVIDIA dGPU (e.g., '01:00.0').";
        };
    };
    #Ensures settings are applied if the enable option is true
    config = lib.mkIf cfg.enable {
        _module.check = {
        assertion = cfg.iGpuBusId != "" && cfg.nvidiaBusId != "";
        message = "NVIDIA Prime Offload requires 'intelBusId' and 'nvidiaBusId' to be set in graphics.nvidiaLaptopOffload.";
    };
    services.xserver.videoDrivers = lib.mkIf (cfg.iGpuType == "intel") [ "modesetting" "nvidia" ]
                                   // lib.mkIf (cfg.iGpuType == "amd") [ "amdgpu" "nvidia" ]; #modesetting is Intel, use amdgpu for amd, setting the order of driver search

    hardware.nvidia.powerManagement.finegrained = true;

    hardware.nvidia.prime ={
      # Conditionally set intelBusId or amdgpuBusId
        intelBusId = lib.mkIf (cfg.iGpuType == "intel") (formatBusId cfg.iGpuBusId);
        amdgpuBusId = lib.mkIf (cfg.iGpuType == "amd") (formatBusId cfg.iGpuBusId); 
        nvidiaBusId = formatBusId cfg.nvidiaBusId;
        offload.enable = true;
        offload.enableOffloadCmd = true; #creates the nvidia-offload command to run programs with gpu accel (basically prime-run)
        sync.enable = false;
    };
    };

}