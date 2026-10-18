{ config, pkgs, inputs, lib, ... }:

let
  custom-hid-fanatecff = { lib, stdenv, fetchFromGitHub, kernel, kernelModuleMakeFlags, bashNonInteractive, linuxConsoleTools, nix-update-script }:
    let
      moduleDir = "lib/modules/${kernel.modDirVersion}/kernel/drivers/hid";
    in
    stdenv.mkDerivation (finalAttrs: {
      pname = "hid-fanatecff";
      version = "0.2.3";

      src = fetchFromGitHub {
        owner = "gotzl";
        repo = "hid-fanatecff";
        tag = finalAttrs.version;
        hash = "sha256-lJ+Pn1OLgZK+T1dsV1mwzAwJJgsouFFwDH7bFUD1SGI=";
      };

      nativeBuildInputs = kernel.moduleBuildDependencies;

      postPatch = ''
        mkdir -p $out/{lib/udev/rules.d,${moduleDir}}

        sed -i '/depmod/d' Makefile
        substituteInPlace Makefile \
          --replace-fail '/etc/udev/rules.d' "$out/lib/udev/rules.d"

          substituteInPlace fanatec.rules \
          --replace-fail '/usr/bin/evdev-joystick' '${lib.getExe' linuxConsoleTools "evdev-joystick"}' \
          --replace-fail '/bin/sh' '${lib.getExe bashNonInteractive}'
      '';

      makeFlags = kernelModuleMakeFlags ++ [
        "KVERSION=${kernel.modDirVersion}"
        "KERNEL_SRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        "MODULEDIR=$(out)/${moduleDir}"
      ];

      passthru.updateScript = nix-update-script { };

      meta = {
        description = "Linux module driver for Fanatec driving wheels";
        homepage = "https://github.com/gotzl/hid-fanatecff";
        license = lib.licenses.gpl2Only;
        platforms = lib.platforms.linux;
      };
    });
in
{
  # Build and load the driver CachyOS
  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage custom-hid-fanatecff { })
  ];

  services.udev.packages = [
    (config.boot.kernelPackages.callPackage custom-hid-fanatecff { })
  ];

  environment.sessionVariables = {
    SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS = "1";
};


services.udev.extraRules = ''
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="0eb7", ATTRS{idProduct}=="1a95", ENV{ID_INPUT}="1", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

  SUBSYSTEM=="input", KERNEL=="event*|js*", ATTRS{idVendor}=="0eb7", ATTRS{idProduct}=="1a95", ENV{ID_INPUT_JOYSTICK}="1", MODE="0666", TAG+="uaccess"

  KERNEL=="uinput", MODE="0660", GROUP="input", TAG+="uaccess"
'';

  users.users.dewm.extraGroups = [ "input" ];
  boot.kernelModules = [ "uinput" ];
}
