{
  description = "NixOS Codium in a shell";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        codium = pkgs.callPackage ./packages/codium-nixos { };

        packages.default = codium;
        apps.default = flake-utils.lib.mkApp { drv =  codium; };
      }
    );
}
