{ pkgs, inputs, ... }: 

{
    imports = [
        ./audio.nix
        ./input.nix
        ./sessions.nix
        ./system.nix
    ];
}

