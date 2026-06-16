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
        beeper-desktop-cli = pkgs.buildGoModule {
          pname = "beeper-desktop-cli";
          version = "0.6.2";

          src = pkgs.fetchFromGitHub {
            owner = "beeper";
            repo = "desktop-api-cli";
            rev = "v0.6.2";
            hash = "sha256-mk/K+6oS7fIVM7rhqcFiphRF4eivujVerAI4S1GwCuo=";
          };

          vendorHash = "sha256-8cwIuhTCyvp4JBfuCzXNEY0Qe+jm8ZQK7cP0qljm8JY=";

          doCheck = false;

          nativeBuildInputs = [ pkgs.go_1_25 ];

          meta = with pkgs.lib; {
            description = "CLI for the Beeper Desktop API";
            homepage = "https://github.com/beeper/desktop-api-cli";
            license = licenses.asl20;
            maintainers = [ ];
          };
        };
      in
      {
        packages = {
          inherit beeper-desktop-cli;
          default = beeper-desktop-cli;
        };
      }
    );
}
