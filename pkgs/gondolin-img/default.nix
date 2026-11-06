{
  stdenvNoCC,
  lib,
  callPackage,
  which,
  e2fsprogs,
  lz4,
  curl,
  cpio,
  gzip,
  gnutar,
  cacert,
}:

let
  gondolin = callPackage ../gondolin { };
in
stdenvNoCC.mkDerivation {
  pname = "gondolin-img";
  version = "0.14.0";

  src = ./.;

  nativeBuildInputs = [
    gondolin
    which
    e2fsprogs
    lz4
    curl
    cpio
    gzip
    gnutar
    cacert
  ];

  # The build downloads Alpine packages and the libkrunfw kernel, so it needs
  # network access. This relies on `sandbox = false` (the default on darwin).
  SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

  buildPhase = ''
    runHook preBuild

    export HOME="$TMPDIR/home"
    mkdir -p "$HOME"

    gondolin build --config build-config.json --output "$out"

    runHook postBuild
  '';

  dontInstall = true;
  dontFixup = true;

  meta = {
    description = "Prebuilt Gondolin guest image assets (Alpine + git/gh)";
  };
}
