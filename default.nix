let pkgs = import (builtins.fetchTarball {
  name = "nixos-unstable-2018-09-12";
  url = https://github.com/NixOS/nixpkgs/archive/19.03.tar.gz;
  sha256 = "0q2m2qhyga9yq29yz90ywgjbn9hdahs7i8wwlq7b55rdbyiwa5dy";
}) {};

in pkgs.stdenv.mkDerivation {
  name = "technikatelier-website";

  src = ./.;

  buildInputs = with pkgs; [
    glibcLocales
    (haskellPackages.ghcWithPackages (ps: with ps; [
      hakyll
    ]))
  ];

  LANG = "de_DE.UTF-8";

  buildPhase = ''
    ghc --make site.hs
    ./site build
  '';

  installPhase = ''
    mkdir $out
    cp -r _site/* $out
  '';
}
