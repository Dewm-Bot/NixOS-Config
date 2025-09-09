# overlay.nix
self: super: {
  yeetmouse = super.yeetmouse.overrideAttrs (old: {
    stdenv = super.llvmPackages_19.stdenv; # matches clang 19
  });
}
