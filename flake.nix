{
  description = "Always-latest super-productivity build from fork, for Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # Optionally, remove this next line if you want to fetch your fork from github directly below.
    # super-productivity-src.url = "github:youruser/super-productivity";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Use current flake source as src!
        superProductivity = pkgs.callPackage ./super-productivity.nix {
          src = ./.;  # This uses your current directory as the src (best for a fork you're developing yourself)
        };

      in {
        packages.default = superProductivity;
        apps.default = flake-utils.lib.mkApp { drv = superProductivity; };
      }
    );
}
