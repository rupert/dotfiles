{ buildNpmPackage, pi-src }:
let
  src = "${pi-src}/packages/coding-agent/examples/extensions/gondolin";
in
buildNpmPackage {
  pname = "pi-extension-gondolin";
  version = (builtins.fromJSON (builtins.readFile "${src}/package.json")).version;
  inherit src;
  npmDepsHash = "sha256-xwzxBfdwJ677iCd0a9essV9qCCUZGoFdXT4cLqNjllI=";
  dontNpmBuild = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r index.ts package.json node_modules $out/
    runHook postInstall
  '';
}
