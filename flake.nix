{
  description = "Beeper Desktop CLI";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://rogernavelsaker.cachix.org"
      "https://nacosolutions.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "rogernavelsaker.cachix.org-1:n1DtzMNhA9Rz4Kg3xlXOi/KceULu8VrMbs9WXyMFQNQ="
      "nacosolutions.cachix.org-1:JzCiW2CLcuLXtwOVAg3SlSK/kpqWbfSFEVenyKVUlug="
    ];
  };


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        beeper-desktop-cli = pkgs.stdenvNoCC.mkDerivation {
          pname = "beeper-desktop-cli";
          version = "0.6.2";

          src = pkgs.fetchurl {
            url = "https://github.com/beeper/cli/releases/download/v0.6.2/beeper-cli-0.6.2-linux-x64.tar.gz";
            sha256 = "a881e1d2bc91e31218b251716644ec5f8d161d5ccb30e7eab66cf2ba6410511d";
          };

          installPhase = ''
            install -Dm755 bin/beeper $out/bin/beeper
          '';

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