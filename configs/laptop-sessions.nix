{ config, pkgs, ... }:
let
  # Define the custom package pointing to your local folder
  sddm-lain-wired = pkgs.stdenv.mkDerivation {
    pname = "sddm-lain-wired-theme";
    version = "local";

    # Point directly to the relative path of your local theme folder
    # Assuming 'sddm-lain-wired-local' is in the same directory as this .nix file
    src = ../themes/SDDM/sddm-lain-wired-theme;

    installPhase = ''
      mkdir -p $out/share/sddm/themes/lain-wired
      cp -aR * $out/share/sddm/themes/lain-wired/
    '';
  };
in
{
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositorCommand = "labwc";

        theme = "lain-wired";

        # Inject the local theme and Qt6 dependencies
        extraPackages = with pkgs; [
            sddm-lain-wired
            kdePackages.qtmultimedia
            kdePackages.qtdeclarative
            kdePackages.qt5compat
        ];
    };

    # Removed the qt6 packages from here. They won't help the Qt5 theme.
    environment.systemPackages = [
        # Any other system packages you need
    ];

    programs.xwayland.enable = true;

    # Desktop Environments
    services.xserver.desktopManager.xfce.enable = true;
    services.xserver.desktopManager.xfce.enableWaylandSession = true;
    services.desktopManager.cosmic.enable = true;
    services.xserver.desktopManager.budgie.enable = true;
}
