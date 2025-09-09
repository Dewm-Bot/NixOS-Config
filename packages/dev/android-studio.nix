{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        android-studio
        android-studio-tools
        android-tools
    ];

    #Gross, we have to actually accept a license agreement in our config...
    #android_sdk.accept_license = true;
}


