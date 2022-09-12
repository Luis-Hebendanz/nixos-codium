{
  description = "NixOS Codium in a shell";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree {
          codium = pkgs.callPackage ./packages/codium-nixos {
            extensionsFromVscodeMarketplace = pkgs.vscode-utils.extensionsFromVscodeMarketplace;
            vscodeDefault = pkgs.vscodium;
          };
        };
        defaultPackage = packages.codium;
        apps.codium = flake-utils.lib.mkApp { drv = packages.codium; };
        defaultApp = apps.codium;
      }

      #checks.${system}.integration-tests = 
    );
}
