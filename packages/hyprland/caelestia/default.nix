{ pkgs, inputs, ... }: {

  services.upower.enable = true;
  environment.systemPackages = with pkgs; [

    inputs.caelestia-shell.packages.${system}.default
    #pkgs.caelestia-shell #OLD, FROM OVERLAY
    (inputs.caelestia-cli.packages.${system}.default.overrideAttrs (oldAttrs: {
      preBuild = (oldAttrs.preBuild or "") + ''
        export SETUPTOOLS_SCM_PRETEND_VERSION="0.1.0"
        export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_CAELESTIA="0.1.0"
      '';
    }))
    #pkgs.caelestia-cli  #OLD, FROM OVERLAY


    # Not sure if all these dependencies are necessary or not
    xdg-desktop-portal-hyprland
    #xdg-desktop-portal-gtk
    hyprpicker
    hypridle
    wl-clipboard
    cliphist
    bluez
    bluez-tools
    inotify-tools
    app2unit
    wireplumber
    trash-cli
    foot
    fish
    fastfetch
    starship
    btop
    jq
    socat
    imagemagick
    curl
    adw-gtk3
    papirus-icon-theme
    kdePackages.qt6ct
    libsForQt5.qt5ct
    nerd-fonts.jetbrains-mono
  ];
}
