{ lib, stdenv, fetchFromGitHub, kernel, kmod, bash, evdev-joystick }: # <--- ADDED bash, evdev-joystick

stdenv.mkDerivation rec {
  pname = "hid-fanatecff";
  version = "0.1.2"; 
  name = "${pname}-${version}-${kernel.modDirVersion}";

  src = fetchFromGitHub {
    owner = "gotzl";
    repo = pname;
    rev = "0f1922f";
    sha256 = "sha256-weA9+yuCT1/ENKf3vFz84rkloYwiqL5GMcDJZXkxm90=";
  };

  nativeBuildInputs = [ kmod ];
  buildInputs = [ kernel.dev ];

  KDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  # --- NEW SECTION ---
  # This runs after unpacking and patches the udev rule file
  # before it gets built or installed.
  postPatch = ''
    echo ":: Patching fanatec.rules"
    # Use | as a separator since we are replacing paths
    sed -i 's|/bin/sh|${bash}/bin/sh|g' fanatec.rules
    sed -i 's|/usr/bin/evdev-joystick|${evdev-joystick}/bin/evdev-joystick|g' fanatec.rules
  '';
  # --- END NEW SECTION ---

  buildPhase = ''
    echo ":: Compiling Fanatec kernel module"
    echo "========================================"
    make -C "${KDIR}" M="$PWD" modules
  '';

  installPhase = ''
    echo ":: Installing Fanatec kernel module/udev rule to $out"
    echo "====================================================="
    
    local modDest="$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/hid"
    mkdir -p "$modDest"
    cp -v hid-fanatec.ko "$modDest/"

    mkdir -p "$out/lib/udev/rules.d"
    # This will now copy the *patched* fanatec.rules
    cp -v fanatec.rules "$out/lib/udev/rules.d/99-fanatec.rules"
  '';

  meta = with lib; {
    description = "Driver to support FANATEC input devices, in particular ForceFeedback of various wheel-bases";
    homepage = "https://github.com/gotzl/hid-fanatecff";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
