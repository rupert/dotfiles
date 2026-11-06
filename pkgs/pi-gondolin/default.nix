{ buildNpmPackage, callPackage }:
let
  src = ./.;
  gondolin-img = callPackage ../gondolin-img { };
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
    cp -r ${gondolin-img} $out/img
    runHook postInstall
  '';
}
