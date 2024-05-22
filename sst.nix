{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "sst";
  version = "0.0.329";

  src = pkgs.fetchzip {
    url = "https://github.com/sst/ion/releases/download/v0.0.329/sst-mac-arm64.tar.gz";
    hash = "sha256-goGoUEXOIJLbDm2BRwy0+NBgjykZdek+aGxyyDaJEps=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp sst $out/bin
  '';
}
