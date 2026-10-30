inputs: final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      anyio = python-prev.anyio.overridePythonAttrs (_: {
        doCheck = false;
      });
      psycopg = python-prev.psycopg.overridePythonAttrs (_: {
        doCheck = false;
        pythonImportsCheck = [
          "psycopg"
          "psycopg_c"
        ];
      });
      fsspec = python-prev.fsspec.overridePythonAttrs (_: {
        doCheck = false;
      });
      watchfiles = python-prev.watchfiles.overridePythonAttrs (_: {
        doCheck = false;
      });
    })
  ];
}
