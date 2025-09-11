{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./configs
      ./configs/laptop-sessions.nix
      ./hardware-conf-laptop.nix
      ./laptop-rog.nix
      ./packages
      ./nvidia.nix
    ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dewm = {
    isNormalUser = true;
    description = "Dewm";
    extraGroups = [ "networkmanager" "wheel" "gaming" "video" "kvm" "vm" ];
  };
  
   networking.hostName = "DewmM16-Nix"; # Define your hostname.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [

  ];


  #I have no idea why I need to put this here:
  nixpkgs.config.nvidia.acceptLicense = true;


  services.flatpak.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.download-buffer-size = 524288000;

  #Additional Flags for Laptop EFI fussy-ness
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.graceful = true;
  boot.loader.efi.canTouchEfiVariables = false;

  #Swap file setup, maybe move to it's own config file?
  boot.resumeDevice = "/dev/disk/by-label/swap";
  boot.kernelParams = ["resume=/dev/disk/by-label/swap"];

  #AppImage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

}
