{
  description = "A dev sandbox";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
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
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          ghc
          pkgs.nodejs
          python
        ];
      };
    };
}
