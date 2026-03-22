inputs: final: prev: {
  app2unit = prev.app2unit.overrideAttrs (old: {
    postFixup = "";
  });

    caelestia-cli = inputs.caelestia-cli.packages.${prev.system}.default.override {
    app2unit = final.app2unit;
  };

  caelestia-shell = inputs.caelestia-shell.packages.${prev.system}.default.override {
    app2unit = final.app2unit;
  };

}
