{ config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    #jetbrains-toolbox  # disabled: fetch 404 on JetBrains CDN (jetbrains-toolbox-3.8.1.88030.tar.gz)
    msbuild
    mono
    dotnetCorePackages.sdk_8_0
    dotnetPackages.Nuget
    libpng
    libpng12
  ];
}
