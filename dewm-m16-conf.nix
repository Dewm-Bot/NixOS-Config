{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./configs
      ./configs/laptop-sessions.nix
      ./dewm-m16-hardware.nix
      ./laptop-rog.nix
      ./packages
      #./nvidia.nix
      #./NAS.nix
    ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dewm = {
    isNormalUser = true;
    description = "Dewm";
    extraGroups = [ "networkmanager" "wheel" "gaming" "video" "kvm" "vm" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia.open = true;
  hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.latest;
  
  networking.hostName = "DewmM16-Nix"; # Define your hostname.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.nix-software-center.packages.${system}.nix-software-center
    #inputs.comfyui-nix.packages.x86_64-linux.cuda
  ];
  
  services.fstrim.enable = true;


  #I have no idea why I need to put this here:
  nixpkgs.config.nvidia.acceptLicense = true;


  nix.settings = {
    # Add binary caches
    substituters = [
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
      "https://comfyui.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "comfyui.cachix.org-1:99Beb4lE1tF5s+vH8s4L5Qh4f7eF18c0c9tN3k0Uf8I="
    ];
  };

  services.flatpak.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.download-buffer-size = 524288000;

  #Additional Flags for Laptop EFI fussy-ness
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.graceful = true;
  boot.loader.efi.canTouchEfiVariables = false;

  #Swap file setup, maybe move to it's own config file?
  #boot.resumeDevice = "/dev/disk/by-label/swap";
  #boot.kernelParams = [
  #  "resume=/dev/disk/by-label/swap"
  #];
  system.stateVersion = "25.11"; # Did you read the comment?

  #Home Manager setup

  home-manager.users.dewm = {
  # Make the home stateVersion follow your system stateVersion so it stays consistent
    home = {
      # example home packages — adjust as you like
      packages = with pkgs; [ ptext micro-full zed-editor-fhs ];
    };
  };
}
