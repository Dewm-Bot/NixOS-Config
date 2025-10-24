{ config, pkgs, inputs, ... }:
let
    kernelPackages = config.boot.kernelPackages;
    # Define your custom kernel module package
    hid-fanatecff-package = kernelPackages.callPackage /etc/nixos/experimental/fanatec {
    # Add these two lines to pass the missing packages
    bash = pkgs.bash;
    evdev-joystick = pkgs.linuxConsoleTools;
    };
in
{
      imports =
      [ # Include the results of the hardware scan.
        ./configs
        ./configs/desktop-sessions.nix
        ./hardware-configuration.nix
        ./amd-stuff.nix
        ./packages
        ./mounts-desktop.nix
    ];


    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.dewm = {
        isNormalUser = true;
        description = "Dewm";
        extraGroups = [ "networkmanager" "wheel" "gaming" "video" "kvm" "vm" ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #I have no idea why I need to put this here:
    nixpkgs.config.nvidia.acceptLicense = true;


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        inputs.nix-software-center.packages.${system}.nix-software-center
    ];


    services.flatpak.enable = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.download-buffer-size = 524288000;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    boot.loader.efi.canTouchEfiVariables = true;


    nix.settings.auto-optimise-store = true;

    #Home Manager setup

    home-manager.users.dewm = {
    # Make the home stateVersion follow your system stateVersion so it stays consistent
        home = {
            stateVersion = config.system.stateVersion;
            # example home packages — adjust as you like
            packages = with pkgs; [ ptext micro-full zed-editor-fhs ];
        };

    };


    # Add the package to the list of kernel modules to build and load
    boot.extraModulePackages = [ hid-fanatecff-package ];

    # Optionally, you might need to ensure udev rules are installed
    # If the package also contains udev rules, you'd add:
    services.udev.packages = [ hid-fanatecff-package ];

    # Optional: Explicitly load the module at boot (usually not necessary if added to extraModulePackages)
    # boot.kernelModules = [ "hid-fanatecff" ];


}
