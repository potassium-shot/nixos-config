{ config, pkgs, ... }:
let home-manager = builtins.fetchTarball {
	url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
	sha256 = "026rvynmzmpigax9f8gy9z67lsl6dhzv2p6s8wz4w06v3gjvspm1";
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
		extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
		packages = with pkgs; [
			bitwarden-desktop
			ghc
			godot
			prismlauncher
			obsidian
			super-productivity
			vesktop
		] ++ (import ./fonts.nix { nerd-fonts = pkgs.nerd-fonts; });
	};

	services.sunshine = {
		enable = true;
		capSysAdmin = true;
		openFirewall = true;
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

