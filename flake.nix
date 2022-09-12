{
  description = "NixOS Codium in a shell";

  outputs = { self, nixpkgs }: {
    nixosModule = import ./modules/codium-nixos;
    nixosModules.default = self.nixosModule;
  };
}
