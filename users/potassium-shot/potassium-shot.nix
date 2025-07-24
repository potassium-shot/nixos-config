{ config, pkgs, ... }:
let home-manager = builtins.fetchTarball {
	url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
	sha256 = "59c316f725037c447c933e0d74269a23f7a9d047fdd4bf8d7fb31eb4dcc765ce";
};
in
{
	imports = [
		(import "${home-manager}/nixos")
		./gaming.nix
	];
	
	users.users.potassium-shot = {
		isNormalUser = true;
		description = "Toni Zana";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			vesktop
			prismlauncher
			godot
		];
	};

	home-manager.users.potassium-shot = {
		home.stateVersion = "25.05";
		home.file.".bashrc".text = builtins.readFile ./.bashrc;
		home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
	};
}

