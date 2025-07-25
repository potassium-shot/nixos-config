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
		] ++ (import ./fonts.nix { nerd-fonts = pkgs.nerd-fonts; });
	};

	home-manager.users.potassium-shot = {
		home.stateVersion = "25.05";
		# Termial & shell
		home.file.".config/kitty/kitty.conf".text = builtins.readFile ./kitty.conf;
		home.file.".bashrc".text = builtins.readFile ./.bashrc;
		home.file.".config/starship.toml".text = builtins.readFile ./starship.toml;

		# Hyprland
		home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
		home.file.".config/hypr/hyprpaper.conf".text = builtins.readFile ./hyprpaper.conf;
		home.file.".config/waybar/config.jsonc".text = builtins.readFile ./waybar/config.jsonc;
		home.file.".config/waybar/macchiato.css".text = builtins.readFile ./waybar/macchiato.css;
		home.file.".config/waybar/style.css".text = builtins.readFile ./waybar/style.css;

		# Wofi
		home.file.".config/wofi/style.css".text = builtins.readFile ./wofi.css;
	};
}

