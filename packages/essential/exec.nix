{ config, pkgs, inputs, self, system, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        nix-ld
        glibc
        libogg
        #(self.inputs.nix-alien.packages.${system}.default)
        libxml2
        gtk3
        gtk3-x11
        iconv
        glibc_multi
        gobject-introspection
        gnumake
        cmake
        gcc
        libgcc
        clang
        libusb1
        particle-cli
        libusbp
        swiftshader
	icu
	icu78
	dotnet-aspnetcore_9
    ];

    systemd.mounts = [
      {
        what = "/run/current-system/sw/bin";
        where = "/home/dewm/.local/current-system-sw-bin";
        type = "none";
        options = "bind,ro";
        wantedBy = [ "multi-user.target" ];
      }
      {
        what = "/run/current-system/sw/share/dotnet";
        where = "/home/dewm/.local/current-system-dotnet";
        type = "none";
        options = "bind,ro";
        wantedBy = [ "multi-user.target" ];
      }
    ];


    programs.nix-ld = {
      enable = true;
      libraries = lib.mkForce (with pkgs; [
        gtk3
        cxxtools
        libz
        zlib
        swiftshader
        zstd
        libgbm
        cxxopts
        xdg-utils-cxx
        gnumake
        cmake
        gcc
        libgcc
        gtk3-x11
        mono5
        msbuild
        libbsd
        xorg.libX11
        gperftools
        libxml2
        protobuf
        xorg.libxkbfile
        gfxstream
        abseil-cpp
        pulseaudio
        glib
        libcxx
        mesa
        SDL
        SDL2
        SDL2_image
        SDL2_mixer
        SDL2_ttf
        SDL_image
        SDL_mixer
        SDL_ttf
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        bzip2
        cairo
        cups
        curlWithGnuTls
        dbus
        dbus-glib
        desktop-file-utils
        e2fsprogs
        expat
        flac
        fontconfig
        freeglut
        freetype
        fribidi
        fuse
        fuse3
        gdk-pixbuf
        glew110
        glib
        gmp
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-ugly
        gst_all_1.gstreamer
        gtk2
        harfbuzz
        icu
        keyutils.lib
        libGL
        libGLU
        libappindicator-gtk2
        libcaca
        libcanberra
        libcap
        libclang.lib
        libdbusmenu
        libdrm
        libgcrypt
        libgpg-error
        libidn
        libjack2
        libjpeg
        libmikmod
        libogg
        libpng
        libpng12
        libpulseaudio
        librsvg
        libsamplerate
        libthai
        libtheora
        libtiff
        libudev0-shim
        libusb1
        libusbp
        libusb-compat-0_1
        libuuid
        libvdpau
        libvorbis
        libvpx
        libxcrypt-legacy
        libxkbcommon
        libxml2
        mesa
        nspr
        nss
        openssl
        p11-kit
        pango
        pixman
        python3
        speex
        stdenv.cc.cc
        tbb
        udev
        vulkan-loader
        wayland
        xorg.libICE
        xorg.libSM
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXft
        xorg.libXi
        xorg.libXinerama
        xorg.libXmu
        xorg.libXrandr
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libpciaccess
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        xorg.xkeyboardconfig
        xz
        zlib
    ]);
  };

environment.sessionVariables = {
  DOTNET_ROOT = "${pkgs.dotnet-aspnetcore_9}/share/dotnet/";
};


}


