{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		amdctl
		msr
	];

	boot.kernelModules = [ "msr" ];

	systemd.services.underclock = {
		script = builtins.readFile ./underclock.sh;
		wantedBy = [ "multi-user.target" ];
	};
}

