{ pkgs, inputs, ... }: 

{
    imports = [
        ./audio.nix
        ./input.nix
        ./system.nix
        ./insecure.nix
	./qt.nix
    ];
}

