{ mkDerivation, callPackage, buildPackages
, async, base, bytestring, containers, fetchFromGitLab, mtl
, parallel-io, parsec, stdenv, stm, transformers
}:
let
  z3 = callPackage ./z3.nix { gomp = null; z3 = buildPackages.z3; };
in let
  sbv = callPackage ./sbv-7.13.nix { inherit z3; };
in
mkDerivation rec {
  pname = "petrinizer";
  version = "0.9.1.1";

  src = fetchFromGitLab {
    domain = "gitlab.lrz.de";
    owner = "i7";
    repo = pname;
    rev = version;
    sha256 = "1n7fzm96gq5rxm2f8w8sr1yzm1zcxpf0b473c6xnhsgqsis5j4xw";
  };

  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    async base bytestring containers mtl parallel-io parsec sbv stm
    transformers
  ];
  description = "Safety and Liveness Analysis of Petri Nets with SMT solvers";
  license = stdenv.lib.licenses.gpl3;
  maintainers = with stdenv.lib.maintainers; [ raskin ];
}
