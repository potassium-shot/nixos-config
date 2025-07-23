{ config, pkgs, ... }:

{
	users.users.potassium-shot.packages = with pkgs; [
		sunshine
	];
}

