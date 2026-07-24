{ config, pkgs, inputs, ... }:
{
      imports =
      [ # Include the results of the hardware scan.
        ./configs
        ./configs/desktop-sessions.nix
        ./configs/ssh.nix
        ./dewmbox-hardware.nix
        ./amd-stuff.nix
        ./packages
        ./mounts-desktop.nix
        ./NAS.nix
        #./experimental/fanatec-pedals
        ./experimental/fanatec
    ];
     systemd.services.nix-daemon = {
        environment = {
            TMPDIR = "/run/media/LoopSpinner/Nix-Build";
        };
    };


    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.dewm = {
        isNormalUser = true;
        description = "Dewm";
        extraGroups = [ "networkmanager" "wheel" "gaming" "video" "kvm" "vm" "input" "render" ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #I have no idea why I need to put this here:
    #nixpkgs.config.nvidia.acceptLicense = true;


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        inputs.nix-software-center.packages.${system}.nix-software-center
    ];


    services.flatpak.enable = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.download-buffer-size = 524288000;

    boot.loader.efi.canTouchEfiVariables = true;


    nix.settings.auto-optimise-store = true;

    #Home Manager setup

    home-manager.users.dewm = {
    # Make the home stateVersion follow your system stateVersion so it stays consistent
        home = {
            # example home packages — adjust as you like
            packages = with pkgs; [ ptext micro-full zed-editor-fhs ];
        };

    };


    boot.kernelParams = [
        "nomodeset" # <--- If you see the issue with this added, try removing it.
        "amdgpu.modeset=1" # Explicitly enable KMS for amdgpu
    ];

    powerManagement.cpuFreqGovernor = "performance";
}
