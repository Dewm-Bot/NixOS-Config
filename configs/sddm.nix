{ pkgs, ... }:
let
  sddm-lain-wired = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-lain-wired-theme";
    version = "0.9-qt6";

    src = ../themes/SDDM/sddm-lain-wired-theme;

    dontWrapQtApps = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/sddm/themes/lain-wired
      cp -aR . $out/share/sddm/themes/lain-wired/
      runHook postInstall
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    theme = "lain-wired";

    # Wrap sddm-greeter-qt6 with the Qt6 QML modules required by the Lain theme.
    extraPackages = with pkgs.kdePackages; [
      qtmultimedia
      qtdeclarative
      qt5compat
    ];
  };

  # NixOS links /share/sddm from environment.systemPackages into /run/current-system/sw/share/sddm.
  environment.systemPackages = [
    sddm-lain-wired
  ];
}
