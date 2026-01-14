{ config, pkgs, deviceType, inputs, ... }:

{
	home.username = "dewm";
	home.homeDirectory = "/home/dewm";
	home.stateVersion = "25.05";

	imports = [
	#./packages/home-pkgs.nix
	];

	home.packages = with pkgs; [
		atool
		httpie
		inputs.jackify.packages.${pkgs.system}.default
	];

	programs.bash.enable = true;

	home.sessionPath = [
    "$HOME/bin"
	];


	home.file.".device_type".text = "${deviceType}";

	#Example of variable use
# 	monitor = if deviceType == "desktop"
#               then "DP-1, 2560x1440@144Hz, 0x0, 1"
#               else "eDP-1, 2560x1600@165Hz, 0x0, 1.25";
# 	};

}
