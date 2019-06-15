{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
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
