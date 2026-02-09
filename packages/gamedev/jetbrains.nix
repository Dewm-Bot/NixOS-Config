{ config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
    msbuild
    mono
    dotnetCorePackages.sdk_8_0
    dotnetPackages.Nuget
    libpng
    libpng12
  ];
}
