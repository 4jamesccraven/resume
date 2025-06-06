{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    reumes.url = "github:4jamesccraven/reumes";
  };

  outputs =
    {
      flake-utils,
      nixpkgs,
      reumes,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        reumes-cli = reumes.packages.${system}.reumes;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            reumes-cli
          ];
        };
      }
    );
}
