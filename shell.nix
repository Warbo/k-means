{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, QuickCheck, stdenv, tasty
      , tasty-quickcheck
      }:
      mkDerivation {
        pname = "k-means";
        version = "0.1.0.0";
        src = ./.;
        libraryHaskellDepends = [ base ];
        testHaskellDepends = [ base QuickCheck tasty tasty-quickcheck ];
        homepage = "http://chriswarbo.net/git/k-means";
        description = "Simple k-means clustering";
        license = stdenv.lib.licenses.publicDomain;
      };

  haskellPackages = if compiler == "default"
                      then pkgs.haskellPackages
                      else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
