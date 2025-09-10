{ config, pkgs, inputs, ... }:

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
  environment.systemPackages = [

  ];


  services.flatpak.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.download-buffer-size = 524288000;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  boot.loader.efi.canTouchEfiVariables = true;

}
