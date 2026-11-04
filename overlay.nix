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
                                                                                                                  
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [                                               
        (python-final: python-prev: {                                                                             
          posthog = python-prev.posthog.overridePythonAttrs (old: {                                               
            doCheck = false;                                                                                      
            meta = (old.meta or { }) // { broken = false; };                                                      
          });                                                                                                     
        })                                                                                                        
      ];                                                                                                          
    }   
