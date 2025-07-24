{ config, pkgs, ... }:
let home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
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

