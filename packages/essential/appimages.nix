{ config, pkgs, inputs, ... }:

{
    programs.appimage = {
        enable = true;
        binfmt = true;
        # Optional: adds extra libraries if certain AppImages fail to launch
        package = pkgs.appimage-run.override {
            extraPkgs = pkgs: [
                pkgs.icu
                pkgs.libxcrypt-legacy
		pkgs.zstd
            ];
        };
    };
}


