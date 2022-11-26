{
  description = "A code sandbox";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
        ghc = pkgs.ghc.withPackages (hs: with hs; [
          bytestring
          cryptonite
          random
        ]);

    in {

      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          ghc
          pkgs.nodejs-16_x
          (pkgs.python3.withPackages (ps: [
            ps.ipython
          ]))
        ];
      };

    };
}
