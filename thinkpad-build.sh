[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
nixos-rebuild switch --flake /etc/nixos/#DewmT14-Nix --impure
nh clean all -k 4 
