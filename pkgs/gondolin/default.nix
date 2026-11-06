{
  buildNpmPackage,
  nodejs_22,
  makeWrapper,
  lib,
  which,
  e2fsprogs,
  lz4,
  curl,
  cpio,
  gzip,
  gnutar,
  cacert,
}:

buildNpmPackage {
  pname = "gondolin";
  version =
    (builtins.fromJSON (builtins.readFile ./package.json))
    .dependencies."@earendil-works/gondolin";

  src = ./.;

  npmDepsHash = "sha256-XdKZseolWQbgzlSPX3AYG933qlqThR7wMYaKByjAKCE=";

  nodejs = nodejs_22;

  dontNpmBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/gondolin
    cp -r node_modules $out/lib/gondolin/

    makeWrapper ${nodejs_22}/bin/node $out/bin/gondolin \
      --add-flags "$out/lib/gondolin/node_modules/@earendil-works/gondolin/dist/bin/gondolin.js" \
      --prefix PATH : ${
        lib.makeBinPath [
          which
          e2fsprogs
          lz4
          curl
          cpio
          gzip
          gnutar
        ]
      } \
      --set SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt" \
      --set NODE_EXTRA_CA_CERTS "${cacert}/etc/ssl/certs/ca-bundle.crt"

    runHook postInstall
  '';
}
