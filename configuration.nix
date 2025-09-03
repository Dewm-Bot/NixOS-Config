{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./configs
      ./hardware-configuration.nix
      ./amd-stuff.nix
      ./packages
    ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dewm = {
    isNormalUser = true;
    description = "Dewm";
    extraGroups = [ "networkmanager" "wheel" "gaming" "video" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

  ];


  services.flatpak.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.download-buffer-size = 524288000;

}
