{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "sst";
  version = "0.0.419";

  src = pkgs.fetchzip {
    url = "https://github.com/sst/ion/releases/download/v0.0.419/sst-mac-arm64.tar.gz";
    hash = "sha256-iuSNf3EuvLaTecjdZAoH1mX6vTltwa5g93kM9gPddGI=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp sst $out/bin
  '';
}
