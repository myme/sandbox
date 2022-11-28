{
  description = "A dev sandbox";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        ghc = pkgs.ghc.withPackages (hs: with hs; [
          bytestring
          cryptonite
          random
        ]);
        python = pkgs.python3.withPackages (ps: with ps; [
          ipython
        ]);
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            ghc
            pkgs.nodejs
            python
          ];
        };
      });
}
