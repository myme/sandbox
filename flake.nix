{
  description = "A code sandbox";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };

    in {

      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          ghc
        ];
      };

    };
}
