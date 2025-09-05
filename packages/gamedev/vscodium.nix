{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
                bbenoist.nix
                ms-python.python
                ms-vscode-remote.remote-ssh
                vscode-extensions.github.copilot
            ] ++ (vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "remote-ssh-edit";
                    publisher = "ms-vscode-remote";
                    version = "0.47.2";
                    sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
                }
                {
                    publisher = "github";
                    name = "copilot-chat";
                    version = "0.30.3";
                    sha256 = "sha256-MugWkmyQx/K/9hFGDAKSG6hC6altD6PImyRAHJms5iU=";
                }
            ]);
        })
    ];
}

