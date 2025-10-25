
{ config, pkgs, inputs, ... }:

{
        services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
        extraRules = [
            {
                "name" = "gamescope";
                "nice" = -20;
            }
            {
                "name" = "gsdewm";
                "nice" = "-20";
            }
            {
                "name" = "pipewire";
                "nice" = "-20";
            }
        ];
    };
}


