{ pkgs, ...}: {

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  environment.etc = {
    "xdg/qt5ct/qt5ct.conf".text = ''
      [Appearance]
      style=Fusion
      color_scheme_path=${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/darker.conf
      custom_palette=true
      standard_dialogs=default
    '';

    "xdg/qt6ct/qt6ct.conf".text = ''
      [Appearance]
      style=Fusion
      color_scheme_path=${pkgs.kdePackages.qt6ct}/share/qt6ct/colors/darker.conf
      custom_palette=true
      standard_dialogs=default
    '';
  };

}
