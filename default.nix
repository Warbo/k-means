{ mkDerivation, base, QuickCheck, stdenv, tasty, tasty-quickcheck
}:
mkDerivation {
  pname = "k-means";
  version = "0.1.0.0";
  src = ./.;
  buildDepends = [ base ];
  testDepends = [ base QuickCheck tasty tasty-quickcheck ];
  homepage = "http://chriswarbo.net/git/k-means";
  description = "Simple k-means clustering";
  license = stdenv.lib.licenses.publicDomain;
}
