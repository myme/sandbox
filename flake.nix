{
  description = "A dev sandbox";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

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
