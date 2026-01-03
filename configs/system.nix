{ config, pkgs, ... }:

{    
    # Bootloader.
    boot.loader.systemd-boot.enable = true;

    # Use latest kernel.
    #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore; #Now defined in flake.nix
    #services.scx.enable = true; # by default uses scx_rustland scheduler

   
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Toronto";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

    # Configure keymap in X11
    services.xserver.xkb = {
    layout = "us";
    variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    boot.kernel.sysctl = {
        "vm.swappiness" = 10;
    };


    services.fstrim.enable = true;

    boot.kernel.sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "vm.max_map_count" = 2147483642;
        "fs.file-max" = 524288;
    };

    nix.settings = {
        max-jobs = "auto";
        cores = 0; # 0 means "use all available cores"
    };


    zramSwap = {
        enable = true; 
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?



    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs;
    [
    #Any additional packages go here.
    ];

    services.samba = {
        enable = true;
        securityType = "user";
    };


}


