{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "kubefwd";
  src = pkgs.fetchurl {
    url = "https://github.com/txn2/kubefwd/releases/download/1.22.3/kubefwd_Darwin_arm64.tar.gz";
    sha256 = "DZqt51p1Vx6oT2CgeTbi+vszHOsiPF/8h0M+yG7xzQU=";
  };

  phases = ["installPhase" "patchPhase"];

  installPhase = ''
    mkdir -p $out/bin
    tar -xf $src
    cp kubefwd $out/bin/kubefwd
  '';
}
