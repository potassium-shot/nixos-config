{
	description = "Potassium Shot's NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/25.05";
	};

	outputs = { nixpkgs, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix
			];
		};
	};
}

