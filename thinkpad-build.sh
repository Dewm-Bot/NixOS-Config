[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
nixos-rebuild switch --flake /etc/nixos/#DewmT14-Nix --impure \
  --option substituters "https://cache.nixos.org https://nyx-cache.chaotic.cx/ https://nix-citizen.cachix.org https://nix-gaming.cachix.org https://hyprland.cachix.org" \
  --option connect-timeout 5 "$@"
nh clean all -k 4 
