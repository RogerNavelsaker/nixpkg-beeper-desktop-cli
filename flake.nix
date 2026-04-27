{
  description = "Beeper Desktop CLI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "beeper-desktop-cli";
          version = "latest";

          src = pkgs.fetchFromGitHub {
            owner = "beeper";
            repo = "desktop-api-cli";
            rev = "main"; # or a specific commit/tag
            hash = "sha256-RXBmzGaTIjDs9BSTALY9CjWVDLikyXRhMkJRAodjSeM=";
          };

          vendorHash = "sha256-8cwIuhTCyvp4JBfuCzXNEY0Qe+jm8ZQK7cP0qljm8JY=";

          doCheck = false;

          nativeBuildInputs = [ pkgs.go_1_25 ];

          meta = with pkgs.lib; {
            description = "CLI for the Beeper Desktop API";
            homepage = "https://github.com/beeper/desktop-api-cli";
            license = licenses.asl20; # Checked from go.mod and repo commonalities
            maintainers = [ ];
          };
        };
      }
    );
}
