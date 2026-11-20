    inputs: final: prev: {                                                                                        
      fuse2 = prev.stdenv.mkDerivation rec {                                                                      
        pname = "fuse";                                                                                           
        version = "2.9.9";                                                                                        
        src = prev.fetchurl {                                                                                     
          url = "https://github.com/libfuse/libfuse/releases/download/fuse-${version}/fuse-${version}.tar.gz";    
          hash = "sha256-0OadXWCMwi/0hDeRrQl/VU3TJUDdyb7XY4zG/qfBtLU=";                                           
        };                                                                                                        
        preConfigure = ''                                                                                         
          export MOUNT_FUSE_PATH=$out/bin                                                                         
          export INIT_D_PATH=$TMPDIR/etc/init.d                                                                   
          export UDEV_RULES_PATH=$TMPDIR/etc/udev/rules.d                                                         
        '';                                                                                                       
        configureFlags = [ "--enable-lib" "--disable-util" ];                                                     
      };                                                                                                          

      # Fix for packages failing due to Nixpkgs' cargoSetupHook enforcing system libs (e.g. aws-lc-sys, zstd-sys, onig_sys, libgit2-sys)
      mqttui = prev.mqttui.overrideAttrs (_old: {
        dontCargoUseSystemLibs = true;
      });

      manga-tui = prev.manga-tui.overrideAttrs (_old: {
        dontCargoUseSystemLibs = true;
      });

      ashell = prev.ashell.overrideAttrs (_old: {
        dontCargoUseSystemLibs = true;
      });

      concord-tui = prev.concord-tui.overrideAttrs (_old: {
        dontCargoUseSystemLibs = true;
      });

      ironbar = prev.ironbar.overrideAttrs (_old: {
        dontCargoUseSystemLibs = true;
      });

      fresh-editor = prev.fresh-editor.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ prev.oniguruma ];
      });

      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [                                               
        (python-final: python-prev: {                                                                             
          posthog = python-prev.posthog.overridePythonAttrs (old: {                                               
            doCheck = false;                                                                                      
            meta = (old.meta or { }) // { broken = false; };                                                      
          });                                                                                                     
        })                                                                                                        
      ];                                                                                                          
    }   
