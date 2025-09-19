{ config, pkgs, ... }:

# let
#   lib = pkgs.lib;
#
#   extra-path = with pkgs; [
#     dotnetCorePackages.sdk_8_0
#     dotnetPackages.Nuget
#     mono
#     msbuild
#     # Add any extra binaries you want accessible to Rider here
#   ];
#
#   extra-lib = with pkgs; [
#     # Add any extra libraries you want accessible to Rider here
#   ];
#
#   # Create a wrapped rider package with extra PATH/LD_LIBRARY_PATH and a /rider symlink.
#   riderWrapped = pkgs.jetbrains.rider.overrideAttrs (oldAttrs: rec {
#     postInstall = (oldAttrs.postInstall or "") + ''
#       # move original binary and create a wrapper that prefixes PATH and LD_LIBRARY_PATH
#       mv $out/bin/rider $out/bin/.rider-toolless
#
#       # use the makeWrapper from pkgs (absolute path inserted at evaluation time)
#       "${pkgs.makeWrapper}" $out/bin/.rider-toolless $out/bin/rider \
#         --argv0 rider \
#         --prefix PATH : "${lib.makeBinPath extra-path}" \
#         --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"
#
#       # Create a /rider symlink so the Unity plugin that assumes `$BINARY/../..` works.
#       # We make $out/rider point back to $out so references like /rider/bin/rider resolve.
#       ln -s ${"$out"} $out/rider || true
#     '';
#   });
# in
{
  environment.systemPackages = with pkgs; [
    # Use the wrapped rider we built above:
#     riderWrapped

    # other JetBrains packages you still want from upstream pkgs:
#     jetbrains.pycharm-community
#     jetbrains.clion
#     jetbrains.rust-rover
    jetbrains-toolbox
    msbuild
    mono
    dotnetCorePackages.sdk_8_0
    dotnetPackages.Nuget
  ];


#   home-manager.users.dewm.home.file = {
#     ".local/share/applications/jetbrains-rider.desktop".source =
#       let
#         desktopFile = pkgs.makeDesktopItem {
#           name = "jetbrains-rider";
#           desktopName = "Rider";
#           exec = "\"${riderWrapped}/bin/rider\"";
#           icon = "rider";
#           type = "Application";
#           extraConfig.NoDisplay = "false";
#         };
#       in
#       "${desktopFile}/share/applications/jetbrains-rider.desktop";
#   };
}
