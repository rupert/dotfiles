{
  stdenvNoCC,
  callPackage,
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
  ];

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
    description = "Gondolin guest image";
  };
}
