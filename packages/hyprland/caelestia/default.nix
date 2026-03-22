{ pkgs, inputs, ... }: {

  services.upower.enable = true;
  environment.systemPackages = with pkgs; [

    #inputs.caelestia-shell.packages.${system}.default
    pkgs.caelestia-shell
    #inputs.caelestia-cli.packages.${system}.default
    pkgs.caelestia-cli
    # Not sure if all these dependencies are necessary or not
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
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
