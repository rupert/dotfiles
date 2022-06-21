{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "ghz";
  src = pkgs.fetchurl {
    url = "https://github.com/bojand/ghz/releases/download/v0.109.0/ghz-darwin-x86_64.tar.gz";
    sha256 = "1uv7vgKW5lAx7Gpi5zEXWyjEreJ4zJv1H00hCXChh1I=";
  };
  
  phases = ["installPhase" "patchPhase"];

  installPhase = ''
    mkdir -p $out/bin
    tar -xf $src
    cp ghz $out/bin/ghz
  '';
}
