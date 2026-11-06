{
  buildNpmPackage,
  nodejs_22,
  makeWrapper,
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
      --add-flags "$out/lib/gondolin/node_modules/@earendil-works/gondolin/dist/bin/gondolin.js"

    runHook postInstall
  '';
}
