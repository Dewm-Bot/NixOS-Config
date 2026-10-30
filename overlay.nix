inputs: final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      posthog = python-prev.posthog.overridePythonAttrs (old: {
        doCheck = false;
        meta = (old.meta or { }) // { broken = false; };
      });
    })
  ];
}
